//
//  SampleScreen.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/14/24.
//

import SwiftUI
import SwiftData

struct SampleScreen: View {
    @Environment (DataCoordinator.self) var dataCoordinator
    @Environment (LanguageCoordinator.self) var languageCoordinator
    @Environment(\.modelContext) private var context
    
    @Query var data: [SampleSwiftDataModel]
    
    var body: some View {
        VStack {
            HStack {
                Styleguide.Title(languageCoordinator.currentContent.swiftDataTutorial.list)
                Spacer()
                SFSymbolButton(symbol: "plus") {
                    context.insert(SampleSwiftDataModel(id: String(UUID().uuidString.prefix(6)), number: data.count, boolean: false, date: Date.now))
                }
                SFSymbolButton(symbol: "arrow.forward") {
                    dataCoordinator.experienceState = .count
                }
            }.padding()
            List(data) { item in
                SwiftDataListRow(item: item) {
                    context.delete(item)
                }
            }
        }
    }
    
    
}

struct SampleScreen_Previews: PreviewProvider {
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
        
        var body: some View {SampleScreen()
                .environment(LanguageCoordinator(languageCode: languageCode))
                .environment(\.locale, .init(identifier: languageCode))
                .environment(DataCoordinator())
                .modelContainer(for: SampleSwiftDataModel.self)
        }
    }
}


