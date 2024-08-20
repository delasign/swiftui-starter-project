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
            HStack {
                Styleguide.Title(languageCoordinator.currentContent.swiftDataTutorial.list)
                Spacer()
                SFSymbolButton(symbol: "plus") {
                    let result = DataCoordinator.shared.addANewObject(id: String(UUID().uuidString.prefix(6)), number: DataCoordinator.shared.sampleSwiftDataModels.count, boolean: false)
                    switch result {
                    case .success(let data):
                        debugPrint("Succesfully created model : \(data)")
                        break
                    case .failure(let error):
                        debugPrint("Failed to create model : \(error)")
                        break
                    }
                }
            }.padding()
            List(DataCoordinator.shared.sampleSwiftDataModels) { item in
                SwiftDataListRow(item: item)
            }
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
                .environment(DataCoordinator.shared)
        }
    }
}


