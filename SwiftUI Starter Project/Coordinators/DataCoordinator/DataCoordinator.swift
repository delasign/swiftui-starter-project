//
//  DataCoordinator.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/20/24.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
@MainActor
class DataCoordinator {
    
    // MARK: Variables
    static let identifier: String = "[DataCoordinator]"
    static let shared: DataCoordinator = DataCoordinator()
        
    // MARK: SwiftData
    let persistantContainer: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: SampleSwiftDataModel.self,
                configurations: ModelConfiguration()
            )
            return container
        } catch {
            fatalError("Failed to create a container")
        }
    }()
    
    var sampleSwiftDataModels: [SampleSwiftDataModel] = []
    
    init() {
        syncObjects()
    }
}
