//
//  isXCodePreview.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/30/24.
//

import Foundation

func isSwiftPreview() -> Bool {
    return ProcessInfo.processInfo.isXCodePreview
}

public extension ProcessInfo {
    
    var isXCodePreview: Bool {
        environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
