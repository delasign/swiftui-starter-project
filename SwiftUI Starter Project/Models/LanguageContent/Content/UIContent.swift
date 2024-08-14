//
//  UIContent.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/14/24.
//

import Foundation
import SwiftUI
import UIContentMacros


@UIContentParent 
struct UIContent: Codable {
    @UIContentChild 
    struct Sample: Codable {
        let sampleString: String
    }
    
}
