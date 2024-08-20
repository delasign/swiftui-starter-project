//
//  SwiftDataListRow.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/20/24.
//

import SwiftUI

struct SwiftDataListRow: View {
    
    @State var item: SampleSwiftDataModel
    
    var body: some View {
        HStack {
            Text("\(item.number)")
            Toggle(item.id, isOn: $item.boolean)
            Spacer(minLength: kPadding)
            SFSymbolButton(symbol: "trash", action: {
                let result = DataCoordinator.shared.deleteAnObject(id: item.id)
                switch result {
                case .success:
                    debugPrint("Succesfully deleted data : \(item.id)")
                    break
                case .failure(let error):
                    debugPrint("Failed to create model : \(error)")
                    break
                }
            }).buttonStyle(PlainButtonStyle())
        }
    }
}

// Please note that you must use the coordinator instance to preview swiftdata.
#Preview {
    SwiftDataListRow(item: DataCoordinator().sampleSwiftDataModels[0])
}
