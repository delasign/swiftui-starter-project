//
//  generateRandomColor.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/30/24.
//

import Foundation
import UIKit
import SwiftUI

func generateRandomColor() -> Color {
    return Color(
        red: CGFloat.random(in: 0.0...1.0),
        green: CGFloat.random(in: 0.0...1.0),
        blue: CGFloat.random(in: 0.0...1.0),
        opacity: 1
    )
}

func generateRandomUIColor() -> UIColor {
    return UIColor(
        red: CGFloat.random(in: 0.0...1.0),
        green: CGFloat.random(in: 0.0...1.0),
        blue: CGFloat.random(in: 0.0...1.0),
        alpha: 1
    )
}
