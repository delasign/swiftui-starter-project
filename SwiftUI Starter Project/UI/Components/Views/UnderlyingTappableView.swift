//
//  UnderlyingTappableView.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/30/24.
//


import SwiftUI

struct UnderlyingTappableView: View {
    
    var body: some View {
        HStack(spacing: kPadding) {
            Image(systemName: "hand.tap.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: kButtonDimension, height: kButtonDimension)
            Text("Can Tap This!")
        }
        // The Frame and ContentShape modifier must be set in the exact order (i.e. frame then content shape). If you do not believe me, remove the two modifiers below and test it in the XCode Preview.
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
    }
}

#Preview {
    UnderlyingTappableView()
}

