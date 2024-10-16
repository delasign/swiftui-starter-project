//
//  Styleguide.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/18/24.
//

import Foundation
import SwiftUI

class Styleguide {
    
    static let identifier: String = "[Styleguide]"
    private let debugAvailableSystemFonts: Bool = false
    
    // MARK: Lifecycle
    init() {
        debugPrint("\(Styleguide.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Initializing.")
        if debugAvailableSystemFonts {
            printSystemFonts()
        }
    }
    
    // MARK: Colors
    static func getBackgroundColor() -> Color {
        return Colors.background

    }

    static func getPrimaryColor() -> Color {
        return Colors.primary
    }
    
    // MARK: Text
    static func Title(_ text: String) -> Text {
        Text(text)
        .font(Font.custom(Fonts.HelveticaNeueBold, size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
    }
    
    static func Body(_ text: String) -> Text {
        Text(text)
        .font(Font.custom(Fonts.HelveticaNeue, size: UIFont.preferredFont(forTextStyle: .body).pointSize))
    }
}
