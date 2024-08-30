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
        GeometryReader { geometry in
            let frame = geometry.size
            VStack(spacing: 10) {
                topView
                    .frame(width: frame.width, height: frame.height*0.4)
                    .background(.red)
                bottomView
                    .frame(width: frame.width, height: frame.height*0.6)
                    .background(.blue)
            }
        }.padding()
    }
    
    var topView: some View {
        HStack(spacing: 10) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Styleguide.Title(languageCoordinator.currentContent.sample.sampleString)
        }
    }
    
    var bottomView: some View {
        Styleguide.Body(languageCoordinator.currentContent.sample.sampleBody)
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


