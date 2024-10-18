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
    @Environment(\.scenePhase) var scenePhase
    @State private var languageCoordinator = LanguageCoordinator()
    let styleguide = Styleguide()
    
    var body: some Scene {
        WindowGroup {
            SampleScreen()
                .environment(languageCoordinator)
        }.onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
                case .active:
                    debugPrint("\(DebuggingIdentifiers.notificationRecieved) App is Active")
                break
                case .background:
                    debugPrint("\(DebuggingIdentifiers.notificationRecieved) App went to the background")
                break
                case .inactive:
                    debugPrint("\(DebuggingIdentifiers.notificationRecieved) App is Inactive")
                break
            @unknown default:
                fatalError("Unknown scene phase: \(newPhase)")
            }
        }
    }
}
