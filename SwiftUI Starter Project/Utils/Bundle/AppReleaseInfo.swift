//
//  Bundle+AppReleaseInfo.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/30/24.
//

import Foundation

extension Bundle {
    public var appVersionShort: String {
        if let result = infoDictionary?["CFBundleShortVersionString"] as? String {
            return result
        } else {
            return "⚠️ App Version Short not available ⚠️"
        }
    }
    public var appVersionLong: String {
        if let result = infoDictionary?["CFBundleVersion"] as? String {
            return result
        } else {
            return "⚠️ App Version Long not available ⚠️"
        }
    }
    public var appName: String {
        if let result = infoDictionary?["CFBundleName"] as? String {
            return result
        } else {
            return "⚠️ App Name not available ⚠️"
        }
    }
}
