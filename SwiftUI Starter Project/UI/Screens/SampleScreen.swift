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
        ZStackExample
    }
    
    var SingleViewExample: some View {
        Styleguide.Title(languageCoordinator.currentContent.sample.sampleString)
        // The Frame and ContentShape modifier must be set in the exact order (i.e. frame then content shape) above the tap gesture in order for it to work. If you do not believe me, remove the two modifiers below and test it in the XCode Preview.
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                debugPrint("\(DebuggingIdentifiers.actionOrEventSucceded) Tapped on Single View")
            }
    }
    
    var ZStackExample: some View {
        ZStack(alignment: .bottom, content: {
            // Consult the UnderlyingTappableView to see the solution.
            UnderlyingTappableView()
                .onTapGesture {
                    debugPrint("\(DebuggingIdentifiers.actionOrEventSucceded) Tapped on Underlying View")
                }
            OverlayingNonTappableView()
                .background(.black)
        })
    }
    
    var VStackExample: some View {
        VStack(spacing: 10) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                Styleguide.Title(languageCoordinator.currentContent.sample.sampleString)
                Styleguide.Body(languageCoordinator.currentContent.sample.sampleBody)
        }
        .padding()
        // The Frame and ContentShape modifier must be set in the exact order (i.e. frame then content shape) above the tap gesture in order for it to work. If you do not believe me, remove the two modifiers below and test it in the XCode Preview.
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            debugPrint("\(DebuggingIdentifiers.actionOrEventSucceded) Tapped on VStack")
        }
        
        
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


