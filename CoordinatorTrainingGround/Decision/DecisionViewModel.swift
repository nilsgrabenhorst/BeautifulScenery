//
//  DecisionViewModel.swift
//  CoordinatorTrainingGround
//
//  Created by nils.grabenhorst on 16.06.22.
//

import UIKit
import BeautifulScenery

class DecisionViewModel: ViewModel {
    weak var owner: DecisionVC?
    @Indirect var coordinator: DecisionCoordinator
    
    func showOrange() {
        coordinator.showOrange()
    }
    
    func showGreen() {
        coordinator.showGreen()
    }
    
    func showCreateProfile() {
        coordinator.showCreateProfile()
    }
}
