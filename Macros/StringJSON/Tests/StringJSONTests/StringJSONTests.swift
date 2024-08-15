import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(StringJSONMacros)
import StringJSONMacros

let testMacros: [String: Macro.Type] = [
    "StringJSONParent": StringJSONParentMacro.self,
    "StringJSONChild": StringJSONChildMacro.self,
]
#endif

final class StringJSONMacrosTests: XCTestCase {
    // MARK: Both Macros
    func testComplexMacros() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            @StringJSONParent
            struct UIContent: Codable {
                @StringJSONChild
                struct Sample: Codable {
                    let sampleString: String
                    let sampleStringTwo: String
                }
            
                @StringJSONChild
                struct SampleTwo: Codable {
                    let abracadrabra: String
                    let justanotherstring: String
                }
            }
            """,
            expandedSource: """
            struct UIContent: Codable {
                struct Sample: Codable {
                    let sampleString: String
                    let sampleStringTwo: String
            
                    init() {
                        self.sampleString = ""
                        self.sampleStringTwo = ""
                    }
                }
                struct SampleTwo: Codable {
                    let abracadrabra: String
                    let justanotherstring: String
            
                    init() {
                        self.abracadrabra = ""
                        self.justanotherstring = ""
                    }
                }

                let sample: Sample
            
                let sampleTwo: SampleTwo
            
                init() {
                    self.sample = Sample()
                    self.sampleTwo = SampleTwo()
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testSingleComplexMacros() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            @StringJSONParent
            struct UIContent: Codable {
                @StringJSONChild
                struct Sample: Codable {
                    let sampleString: String
                    let sampleStringTwo: String
                    let justAnotherString: String
                }
            }
            """,
            expandedSource: """
            struct UIContent: Codable {
                struct Sample: Codable {
                    let sampleString: String
                    let sampleStringTwo: String
                    let justAnotherString: String
            
                    init() {
                        self.sampleString = ""
                        self.sampleStringTwo = ""
                        self.justAnotherString = ""
                    }
                }

                let sample: Sample
            
                init() {
                    self.sample = Sample()
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // MARK: Parent Error Tests
    
    /* The parent must:
        1. Be a struct.
        2. Confirm to a codable struct.
        3. Have at least one child
        4. Have only structs that confirm
        5. Can only have children that confirm to the @StringJSONChild macro.
     */
    
    // 1. The Parent Must Confirm to a struct.
    func testParentMustConfirmToAStruct() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            @StringJSONParent
            class UIContent: Codable {
                struct Sample: Codable {
                    let sampleString: String
                }
            }
            """,
            expandedSource: """
            class UIContent: Codable {
                struct Sample: Codable {
                    let sampleString: String
                }
            }
            """,
            diagnostics: [DiagnosticSpec(message: StringJSONMacroError.parentNotACodableStruct.description, line: 1, column: 1)],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // 2. The Parent Must Confirm to a codable protocol.
    func testParentMustConfirmToACodableProtocol() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            @StringJSONParent
            struct UIContent {
                struct Sample: Codable {
                    let sampleString: String
                }
            }
            """,
            expandedSource: """
            struct UIContent {
                struct Sample: Codable {
                    let sampleString: String
                }
            }
            """,
            diagnostics: [DiagnosticSpec(message: StringJSONMacroError.parentNotACodableStruct.description, line: 1, column: 1)],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // 3. StringJSONParent must have at least one child that is a struct.
    
    func testParentMustHaveAtleastOneStringJSONChild() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            @StringJSONParent
            struct UIContent: Codable {
            }
            """,
            expandedSource: """
            struct UIContent: Codable {
            }
            """,
            diagnostics: [DiagnosticSpec(message: StringJSONMacroError.parentMustHaveAtLeastOneChildThatIsAStruct.description, line: 1, column: 1)],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // 4. Have only structs that confirm
    
    func testParentDoesNotAllowVariables() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            @StringJSONParent
            struct UIContent: Codable {
                var sample: String = ""
            }
            """,
            expandedSource: """
            struct UIContent: Codable {
                var sample: String = ""
            }
            """,
            diagnostics: [DiagnosticSpec(message: StringJSONMacroError.parentCanOnlyHoldStructsThatAbideToTheStringJSONMacro.description, line: 1, column: 1)],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testParentDoesNotAllowConstants() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            @StringJSONParent
            struct UIContent: Codable {
                let sample: Int = 0
            }
            """,
            expandedSource: """
            struct UIContent: Codable {
                let sample: Int = 0
            }
            """,
            diagnostics: [DiagnosticSpec(message: StringJSONMacroError.parentCanOnlyHoldStructsThatAbideToTheStringJSONMacro.description, line: 1, column: 1)],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testParentDoesNotAllowConstantsEvenIfOtherConditionsAreMet() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            @StringJSONParent
            struct UIContent: Codable {
                let sample: Int = 0
                @StringJSONChild
                struct Sample: Codable {
                    let sampleString: String
                    let sampleStringTwo: String
                    let justAnotherString: String
                }
            }
            """,
            expandedSource: """
            struct UIContent: Codable {
                let sample: Int = 0
                struct Sample: Codable {
                    let sampleString: String
                    let sampleStringTwo: String
                    let justAnotherString: String

                    init() {
                        self.sampleString = ""
                        self.sampleStringTwo = ""
                        self.justAnotherString = ""
                    }
                }
            }
            """,
            diagnostics: [DiagnosticSpec(message: StringJSONMacroError.parentCanOnlyHoldStructsThatAbideToTheStringJSONMacro.description, line: 1, column: 1)],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // 5. Children of the parent must confirm to the @StringJSONChild macro
    func testParentChildrenMustConfirmToTheStringJSONChildMacro() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            @StringJSONParent
            struct UIContent: Codable {
                struct Sample: Codable {
                    let sampleString: String
                }
            }
            """,
            expandedSource: """
            struct UIContent: Codable {
                struct Sample: Codable {
                    let sampleString: String
                }
            }
            """,
            diagnostics: [DiagnosticSpec(message: StringJSONMacroError.parentChildrenNotStringJSONChildren.description, line: 1, column: 1)],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // MARK: Child Error Tests
    
    /* The child must:
        1. Be a struct.
        2. Confirm to a codable struct.
        3. Have at least one string
        4. Cannot hold anything other than string variables.
        5. Only have string variables
     */
    
    // 1. The child Must Confirm to a struct.
    func testChildMustConfirmToAStruct() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            struct UIContent: Codable {
                @StringJSONChild
                class Sample: Codable {
                    let sampleString: String
                }
            }
            """,
            expandedSource: """
            struct UIContent: Codable {
                class Sample: Codable {
                    let sampleString: String
                }
            }
            """,
            diagnostics: [DiagnosticSpec(message: StringJSONMacroError.childNotACodableStruct.description, line: 2, column: 5)],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // 2. The Child Must Confirm to a codable protocol.
    func testChildMustConfirmToACodableProtocol() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            struct UIContent: Codable {
                @StringJSONChild
                class Sample {
                    let sampleString: String
                }
            }
            """,
            expandedSource: """
            struct UIContent: Codable {
                class Sample {
                    let sampleString: String
                }
            }
            """,
            diagnostics: [DiagnosticSpec(message: StringJSONMacroError.childNotACodableStruct.description, line: 2, column: 5)],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // 3. The child must have at least one string variable.
    
    func testChildMustHoldAtLeastOneStringVariable() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            struct UIContent: Codable {
                @StringJSONChild
                struct Sample: Codable {
                }
            }
            """,
            expandedSource: """
            struct UIContent: Codable {
                struct Sample: Codable {
                }
            }
            """,
            diagnostics: [DiagnosticSpec(message: StringJSONMacroError.childMustHaveAtLeastOneVariable.description, line: 2, column: 5)],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // 4. The child cannot hold anything other than string variables.
    func testChildCannotHoldAnythingOtherThanStrings() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            struct UIContent: Codable {
                @StringJSONChild
                struct Sample: Codable {
                    let sample: String
                    struct SampleStruct: Codable {
                        let sampleStructString: String
                    }
                }
            }
            """,
            expandedSource: """
            struct UIContent: Codable {
                struct Sample: Codable {
                    let sample: String
                    struct SampleStruct: Codable {
                        let sampleStructString: String
                    }
                }
            }
            """,
            diagnostics: [DiagnosticSpec(message: StringJSONMacroError.childCannotHoldAnythingOtherThanStringVariables.description, line: 2, column: 5)],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    
    // 4. The Child must only have strings
    func testChildMustOnlyHaveStrings() throws {
        #if canImport(StringJSONMacros)
        assertMacroExpansion(
            """
            struct UIContent: Codable {
                @StringJSONChild
                struct Sample: Codable {
                    let sampleString: Int
                }
            }
            """,
            expandedSource: """
            struct UIContent: Codable {
                struct Sample: Codable {
                    let sampleString: Int
                }
            }
            """,
            diagnostics: [DiagnosticSpec(message: StringJSONMacroError.childMustOnlyHaveStrings.description, line: 2, column: 5)],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
