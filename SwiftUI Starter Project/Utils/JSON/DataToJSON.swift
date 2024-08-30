//
//  DataToJSON.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/30/24.
//

import Foundation

func convertDataToJSON<T: Decodable>(_: T.Type, data: Data) -> T? {
    do {
        let decodedJSON = try JSONDecoder().decode(T.self, from: data)
        debugPrint("convertDataToJSON \(DebuggingIdentifiers.actionOrEventSucceded) decodedJSON : \(decodedJSON)")
        return decodedJSON
    } catch {
        debugPrint("convertDataToJSON \(DebuggingIdentifiers.actionOrEventFailed) error : \(error)")
        return nil
    }
}

