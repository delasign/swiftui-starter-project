//
//  SFSymbolButton.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/20/24.
//

import SwiftUI

struct SFSymbolButton: View {
    @State private var isPressed: Bool = false
    let symbol: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: symbol)
        }
        .frame(width: kButtonDimension, height: kButtonDimension)
        .foregroundColor(isPressed ? Styleguide.getBackgroundColor() : Styleguide.getPrimaryColor())
        .background(isPressed ? Styleguide.getPrimaryColor() : Styleguide.getBackgroundColor())
        .clipShape(.circle)
        .shadow(radius: kShadowSize, x: 0, y: 5)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    withAnimation {
                        isPressed = true
                    }
                })
                .onEnded({ _ in
                    withAnimation {
                        isPressed = false
                    }
                })
        )
    }
}

#Preview {
    SFSymbolButton(symbol: "plus", action: {
        debugPrint("SFSymbolButton was pressed.")
    })
}
