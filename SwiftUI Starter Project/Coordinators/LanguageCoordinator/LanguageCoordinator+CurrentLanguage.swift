//
//  LanguageCoordinator+CurrentLanguage.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/14/24.
//

import Foundation
import UIKit

extension LanguageCoordinator {
    public func determineCurrentLanguage() {
        let newLanguage: Language

        switch self.languageCode {
        // US Spanish, Spanish, Catalan and Basque reset to spanish
        case "es", "eu", "ca", "es-US":
            newLanguage = .spanish
            break
        default:
            newLanguage = .english
            break
        }

        self.currentLanguage = newLanguage
    }
}
