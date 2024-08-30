//
//  JSONToData.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/30/24.
//

import Foundation

func convertJSONToData<T: Encodable>(item: T) -> Data? {
    do {
        let encodedJSON = try JSONEncoder().encode(item)
        debugPrint("convertJSONToData \(DebuggingIdentifiers.actionOrEventSucceded) data : \(encodedJSON)")
        return encodedJSON
    } catch {
        debugPrint("convertJSONToData \(DebuggingIdentifiers.actionOrEventFailed) error : \(error)")
        return nil
    }
}

