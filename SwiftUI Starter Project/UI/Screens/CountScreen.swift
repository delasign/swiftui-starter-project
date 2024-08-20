//
//  CountScreen.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/20/24.
//

import SwiftUI
import SwiftData

struct CountScreen: View {
    @Environment (DataCoordinator.self) var dataCoordinator
    @Environment (LanguageCoordinator.self) var languageCoordinator
    @Environment(\.modelContext) private var context
    
    @Query var data: [SampleSwiftDataModel]
    
    var body: some View {
        VStack {
            HStack {
                Styleguide.Title(languageCoordinator.currentContent.swiftDataTutorial.countScreenTitle)
                Spacer()
                SFSymbolButton(symbol: "arrow.backward") {
                    dataCoordinator.experienceState = .list
                }
            }.padding()
            Spacer()
            Styleguide.Title("\(languageCoordinator.currentContent.swiftDataTutorial.count) \(data.count)")
            Spacer()
        }
    }
    
    
}

struct CountScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(LanguageCoordinator().availableLanguages.values.sorted(by: { "\($0)" < "\($1)" }), id: \.self) { language in
                    ForEach(ColorScheme.allCases, id: \.self) { scheme in
                        LocalizableScreen(languageCode: language).preferredColorScheme(scheme)
                }
            }
            
        }
    }
    
    struct LocalizableScreen: View {
        let languageCode: String
        
        var body: some View {CountScreen()
                .environment(LanguageCoordinator(languageCode: languageCode))
                .environment(\.locale, .init(identifier: languageCode))
                .environment(DataCoordinator())
                .modelContainer(for: SampleSwiftDataModel.self)
        }
    }
}


