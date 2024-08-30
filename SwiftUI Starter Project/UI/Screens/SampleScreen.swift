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
        // Create a Bindable referenece to the environment object
        @Bindable var langCoord = languageCoordinator
        // Apply the Bindable
        Toggle(isOn: $langCoord.sampleBooleanToDemonstrateBindable, label: {
            Text("Toggle Environment Variable")
        })
        .padding()
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
        }
    }
}


