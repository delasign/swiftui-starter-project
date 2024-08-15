// The Swift Programming Language
// https://docs.swift.org/swift-book

/// Defines a subset of the `StringJSON` macro
///
/// Generates two members:
///  - A `StringJSONParent` macro creates variables and an initializer for each of the codables within the UIContent.
///  - A `StringJSONChild` macro creates an initializer for each of the strings within a codable struct.
///
/// - Important: All codable cases declared in this macro must also exist in the
///              `UIContent` struct.
@attached(member, names: arbitrary)
public macro StringJSONParent() = #externalMacro(module: "StringJSONMacros", type: "StringJSONParentMacro")

@attached(member, names: named(init))
public macro StringJSONChild() = #externalMacro(module: "StringJSONMacros", type: "StringJSONChildMacro")
