//
//  LanguageCoordinator.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/14/24.
//

import Foundation
import SwiftUI

@Observable
class LanguageCoordinator {

    // MARK: Variables
    static let identifier: String = "[LanguageCoordinator]"
    static let contentPrefix = "ui_content_"
    
    let languageCode: String

    var currentLanguage: Language = .english {
        didSet {
            if availableLanguages.keys.contains(currentLanguage) {
                debugPrint("\(LanguageCoordinator.identifier) currentLanguage \(DebuggingIdentifiers.actionOrEventSucceded) Valid language : \(currentLanguage)")
            } else {
                debugPrint("\(LanguageCoordinator.identifier) currentLanguage \(DebuggingIdentifiers.actionOrEventFailed) Invalid language : \(currentLanguage), resetting to english")
                currentLanguage = .english
            }
        }
    }

    var currentContent: UIContent = UIContent()

    private let availableLanguages: [Language: String] = [
        .english: "en",
        .spanish: "es"
    ]

    var languageContent: [[Language: UIContent]] = [[Language: UIContent]]() {
        didSet {
            languageContent.forEach { (item) in
                if let key = item.first?.key,
                   let value = item.first?.value,
                   key == self.currentLanguage {
                    debugPrint("\(LanguageCoordinator.identifier) languageContent \(DebuggingIdentifiers.actionOrEventSucceded) Updated Language Content to : \(key)")
                    self.currentContent = value
                }
            }
        }
    }

    // MARK: Lifecycle

    init(languageCode: String? = nil) {
        debugPrint("\(LanguageCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Initializing.")
        
        
        if let environmentLanguageCode = languageCode {
            debugPrint("\(LanguageCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventSucceded) set language code to environemnt language `\(environmentLanguageCode)`.")
            self.languageCode = environmentLanguageCode
        } else if let code = Locale.preferredLanguages.first {
            debugPrint("\(LanguageCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventSucceded) set language code to `\(code)`.")
            self.languageCode = code
        } else {
            debugPrint("\(LanguageCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventFailed) Failed to find current language. Defaulting language code to `en`.")
            self.languageCode = "en"
        }
        
        // Determine languages
        self.determineCurrentLanguage()
        // Generate Languages
        self.generateLanguageContent(languages: self.availableLanguages)
        debugPrint("\(LanguageCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventSucceded) Initialized.")
    }
}
