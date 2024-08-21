//
//  SampleSwiftDataModel.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/20/24.
//

import Foundation
import SwiftData

@Model
final class SampleSwiftDataModel: Identifiable {
    @Attribute(.unique) var id: String
    var number: Int
    var boolean: Bool
    var date: Date
    
    init(id: String, number: Int, boolean: Bool, date: Date) {
        self.id = id
        self.number = number
        self.boolean = boolean
        self.date = date
    }
}
