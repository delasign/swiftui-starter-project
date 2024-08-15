//
//  File.swift
//  
//
//  Created by Oscar de la Hera Gomez on 8/15/24.
//

import Foundation

public enum StringJSONMacroError: CustomStringConvertible, Error {
    case parentNotACodableStruct
    case parentChildrenNotStringJSONChildren
    case parentMustHaveAtLeastOneChildThatIsAStruct
    case parentCanOnlyHoldStructsThatAbideToTheStringJSONMacro
    case childNotACodableStruct
    case childCannotHoldAnythingOtherThanStringVariables
    case childMustHaveAtLeastOneVariable
    case childMustOnlyHaveStrings
    
    public var description: String {
        switch self {
        case .parentNotACodableStruct:
            return "@StringJSONParent can only be applied to a struct that uses a codable protocol."
        case .parentChildrenNotStringJSONChildren:
            return "@StringJSONParent can only be applied if its children use conform to the @StringJSONChild macro."
        case .parentMustHaveAtLeastOneChildThatIsAStruct:
            return "@StringJSONParent must hold at least one struct that conforms to the @StringJSONChild macro."
        case .parentCanOnlyHoldStructsThatAbideToTheStringJSONMacro:
            return "@StringJSONParent can only hold structs that conforms to the @StringJSONChild macro."
        case .childNotACodableStruct:
            return "@StringJSONChild can only be applied to a struct that uses a codable protocol."
        case .childMustOnlyHaveStrings:
            return "@StringJSONChild can only hold strings."
        case .childCannotHoldAnythingOtherThanStringVariables:
            return "@StringJSONChild cannot hold anything other than string constants or variables."
        case .childMustHaveAtLeastOneVariable:
            return "@StringJSONChild can only hold variables."
        }
    }
}
