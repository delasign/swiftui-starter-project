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
    
    private var dataCoordinator = DataCoordinator()
    @State private var languageCoordinator = LanguageCoordinator()
    let styleguide = Styleguide()
    
    var body: some Scene {
        WindowGroup {
            switch dataCoordinator.experienceState {
            case .list:
                SampleScreen()
                    .environment(languageCoordinator)
                    .environment(dataCoordinator)
                    .modelContainer(for: SampleSwiftDataModel.self)
            case .count:
                CountScreen()
                    .environment(languageCoordinator)
                    .environment(dataCoordinator)
                    .modelContainer(for: SampleSwiftDataModel.self)
            }
        }
    }
}
