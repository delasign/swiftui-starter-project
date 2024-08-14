//
//  App.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/14/24.
//

import SwiftUI

// Please note that "Application" cannot be named App.
@main
struct Application: App {
    
    @State private var languageCoordinator = LanguageCoordinator()
    
    var body: some Scene {
        WindowGroup {
            SampleScreen().environment(languageCoordinator)
        }
    }
}
