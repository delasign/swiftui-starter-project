//
//  SampleScreen.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/14/24.
//

import SwiftUI

struct SampleScreen: View {
    @Environment (LanguageCoordinator.self) var languageCoordinator
        
    var body: some View {
        fillWidthAndHeight
    }
    
    var noFill: some View {
        VStack(spacing: 10) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                Styleguide.Title(languageCoordinator.currentContent.sample.sampleString)
                Styleguide.Body(languageCoordinator.currentContent.sample.sampleBody)
        }
        .background(.red)
    }
    
    var fillWidth: some View {
        VStack(spacing: 10) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                Styleguide.Title(languageCoordinator.currentContent.sample.sampleString)
                Styleguide.Body(languageCoordinator.currentContent.sample.sampleBody)
        }
        .frame(maxWidth: .infinity)
        // Color must be at the end if you want it to occupy the entire area.
        // Move above the frame to see it occupy only the content.
        .background(.red)
    }
    
    var fillHeight: some View {
        VStack(spacing: 10) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                Styleguide.Title(languageCoordinator.currentContent.sample.sampleString)
                Styleguide.Body(languageCoordinator.currentContent.sample.sampleBody)
        }
        
        .frame(maxHeight: .infinity)
        // Color must be at the end if you want it to occupy the entire area.
        // Move above the frame to see it occupy only the content.
        .background(.red)
    }
    
    var fillWidthAndHeight: some View {
        VStack(spacing: 10) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                Styleguide.Title(languageCoordinator.currentContent.sample.sampleString)
                Styleguide.Body(languageCoordinator.currentContent.sample.sampleBody)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // Color must be at the end if you want it to occupy the entire area.
        // Move above the frame to see it occupy only the content.
        .background(.red)
        
    }
    
}

struct SampleScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(LanguageCoordinator().availableLanguages.values.sorted(by: { "\($0)" < "\($1)" }), id: \.self) { language in
                    ForEach(ColorScheme.allCases, id: \.self) { scheme in
                    LocalizableSampleScreen(languageCode: language).preferredColorScheme(scheme)
                }
            }
            
        }
    }
    
    struct LocalizableSampleScreen: View {
        let languageCode: String
        
        var body: some View {SampleScreen()
                .environment(LanguageCoordinator(languageCode: languageCode))
                .environment(\.locale, .init(identifier: languageCode))
                // Remove "Padding" to remove safe area insets.
                .padding()
        }
    }
}


