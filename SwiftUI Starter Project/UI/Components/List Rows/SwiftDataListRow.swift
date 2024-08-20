//
//  SwiftDataListRow.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/20/24.
//

import SwiftUI
import SwiftData

struct SwiftDataListRow: View {
    
    @Bindable var item: SampleSwiftDataModel
    let action: () -> Void
    var body: some View {
        HStack {
            Text("\(item.number)")
            Toggle(item.id, isOn: $item.boolean)
            Spacer(minLength: kPadding)
            SFSymbolButton(symbol: "trash", action: {
                action()
            })
            // Please note that the PlainButtonStyle is required in order for the list to trigger the button as expected.
            .buttonStyle(PlainButtonStyle())
        }
    }
}


// Please note that to preview the data you must create a mock container that holds the data.
#Preview {
    let container = try! ModelContainer(for: SampleSwiftDataModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    let mockItem = SampleSwiftDataModel(id: String(UUID().uuidString.prefix(6)), number: 0, boolean: false, date: Date.now)

    container.mainContext.insert(mockItem)

    return SwiftDataListRow(item: mockItem) {}
}
