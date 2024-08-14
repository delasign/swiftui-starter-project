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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(languageCoordinator.currentContent.sample.sampleString)
        }
        .padding()
    }
}

#Preview {
    SampleScreen()
        .environment(LanguageCoordinator())
}
