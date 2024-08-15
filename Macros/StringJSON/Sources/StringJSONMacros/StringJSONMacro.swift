import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `StringJSONParent` macro.
public struct StringJSONParentMacro: MemberMacro {
    public static func expansion(
        of attribute: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        var finalSyntaxDeclarations: [DeclSyntax] = []
        
        // The StringJSONParent must abide to a struct that uses a codable protocol.
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            throw StringJSONMacroError.parentNotACodableStruct
        }
        
        guard let inheritedType = structDecl.inheritanceClause?.inheritedTypes.first,
              inheritedType.type.description.contains("Codable") else {
            throw StringJSONMacroError.parentNotACodableStruct
        }
    
        
        let members = structDecl.memberBlock.members
        
        // Gather the contentStructs (i.e. let sample = Sample())
        let contentStructs = members.compactMap({ $0.decl.as(StructDeclSyntax.self)})
        
        // The StringJSONParent cannot have any variables or constants.
        guard (members.count - contentStructs.count) == 0 else {
            throw StringJSONMacroError.parentCanOnlyHoldStructsThatAbideToTheStringJSONMacro
        }
        
        // The StringJSONParent must hold at least one child that is a struct that conforms to the StringJSONChild macro.
        guard !contentStructs.isEmpty else {
            throw StringJSONMacroError.parentMustHaveAtLeastOneChildThatIsAStruct
        }
        
        // Make sure that they confirm to the @StringJSONChild macro.
        try contentStructs.forEach { content in
            print("ContentStruct content :", content)
            if !content.attributes.description.contains("StringJSONChild") {
                throw StringJSONMacroError.parentChildrenNotStringJSONChildren
            }
        }
        
        // All Tests have passed - Complete the Macro.
        
        // Gather the Codable Names
        var codables: [String] = []
        contentStructs.forEach { element in
            codables.append(element.name.text)
        }
        
        // Add all the relevant variables declarations (i.e. let sample: Sample
        try codables.forEach { element in
            let variableDeclaration =  try VariableDeclSyntax("let \(raw: element.camelCased): \(raw: element)")
            finalSyntaxDeclarations.append(DeclSyntax(variableDeclaration))
        }
        // Add the intializer
        let intializer = try InitializerDeclSyntax("init()") {
            for element in codables {
                """
                self.\(raw: element.camelCased) = \(raw: element)()
                """
            }
        }
        finalSyntaxDeclarations.append(DeclSyntax(intializer))
        
        // Return all the new declarations
        return finalSyntaxDeclarations
    }
}

/// Implementation of the `StringJSONChild` macro.
public struct StringJSONChildMacro: MemberMacro {
    public static func expansion(
        of attribute: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        
        // The StringJSONChild must abide to a struct that uses a codable protocol.
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            throw StringJSONMacroError.childNotACodableStruct
        }
        
        guard let inheritedType = structDecl.inheritanceClause?.inheritedTypes.first,
              inheritedType.type.description.contains("Codable") else {
            throw StringJSONMacroError.childNotACodableStruct
        }
        
        let members = structDecl.memberBlock.members
        
        // Gather the contentConstants (i.e. let sample = Sample())
        let contentConstants = members.compactMap({ $0.decl.as(VariableDeclSyntax.self)})
        
        // The StringJSONParent cannot anything other than string variables or constants.
        guard contentConstants.count > 0 else {
            throw StringJSONMacroError.childMustHaveAtLeastOneVariable
        }
        
        guard members.count - contentConstants.count == 0 else {
            throw StringJSONMacroError.childCannotHoldAnythingOtherThanStringVariables
        }
        
        try contentConstants.forEach { constant in
            try constant.bindings.forEach { binding in
                if let typeAnnotation = binding.typeAnnotation, !typeAnnotation.type.description.contains("String") {
                    throw StringJSONMacroError.childMustOnlyHaveStrings
                }
            }
        }
        
        // All Tests have passed - Complete the Macro.
        
        // Write the initializer
        let intializer = try InitializerDeclSyntax("init()") {
            for constant in contentConstants {
                if let binding = constant.bindings.first {
                    """
                    self.\(raw: binding.pattern.description) = ""
                    """
                }
            }
        }
    
        return [DeclSyntax(intializer)]
    }
}

@main
struct StringJSONPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringJSONParentMacro.self,
        StringJSONChildMacro.self,
    ]
}


// MARK: Helper
extension String {
    var lowercasingFirst: String { prefix(1).lowercased() + dropFirst() }
    var uppercasingFirst: String { prefix(1).uppercased() + dropFirst() }

    var camelCased: String {
        guard !isEmpty else { return "" }
        let parts = components(separatedBy: .alphanumerics.inverted)
        let first = parts.first!.lowercasingFirst
        let rest = parts.dropFirst().map { $0.uppercasingFirst }

        return ([first] + rest).joined()
    }
}
