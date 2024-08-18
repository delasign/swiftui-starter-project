//
//  UIContent.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/14/24.
//

import Foundation
import SwiftUI
import StringJSON


@StringJSONParent
struct UIContent: Codable {
    @StringJSONChild
    struct Sample: Codable {
        let sampleString: String
        let sampleBody: String
    }
}
