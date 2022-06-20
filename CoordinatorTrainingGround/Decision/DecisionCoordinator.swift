//
//  DecisionCoordinator.swift
//  CoordinatorTrainingGround
//
//  Created by nils.grabenhorst on 16.06.22.
//

import UIKit
import BeautifulScenery

class DecisionCoordinator: Coordinator {
    weak var owner: DecisionVC?
    
    func showOrange() {
        show(OrangeScene())
    }
    
    func showGreen() {
        present(GreenScene())
    }
    
    func showCreateProfile() {
        present(
            NavigationRoot(
                EnterName()
            )
        )
    }
}
