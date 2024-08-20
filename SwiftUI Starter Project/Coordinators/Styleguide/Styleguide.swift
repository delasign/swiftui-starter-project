//
//  Styleguide.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/18/24.
//

import Foundation
import SwiftUI


class Styleguide {
    @Environment (\.colorScheme) static var colorScheme
    
    static let identifier: String = "[Styleguide]"
    private let debugAvailableSystemFonts: Bool = false
    
    // MARK: Lifecycle
    init() {
        debugPrint("\(Styleguide.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Initializing.")
        if debugAvailableSystemFonts {
            printSystemFonts()
        }
    }
    
    static let isDarkMode: Bool = {
        return Styleguide.colorScheme == .dark
    }()
    
    // MARK: Colors
    static func getBackgroundColor() -> Color {
        if #available(iOS 13.0, *) {
            return isDarkMode ? Colors.black : Colors.white
        } else {
            return Colors.white
        }

    }

    static func getPrimaryColor() -> Color {
        if #available(iOS 13.0, *) {
            return isDarkMode ? Colors.white : Colors.black
        } else {
            return Colors.black
        }
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
