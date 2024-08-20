//
//  DataCoordinator.swift
//  SwiftUI Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/20/24.
//

import Foundation
import SwiftUI

@Observable
class DataCoordinator {
    static let identifier: String = "DataCoordinator"
    var experienceState: ExperienceStates = .list
}
