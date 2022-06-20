//
//  DecisionViewController.swift
//  CoordinatorTrainingGround
//
//  Created by nils.grabenhorst on 15.06.22.
//

import UIKit
import BeautifulScenery

struct DecisionScene {
    let coordinator = DecisionCoordinator()
}

class DecisionVC: UIViewController, Coordinated, ViewModeled {
    typealias C = DecisionCoordinator
    
    var coordinator: DecisionCoordinator! = DecisionCoordinator()
    var viewModel: DecisionViewModel! = DecisionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.owner = self
        viewModel.owner = self
    }
    
    @IBAction func orangeTapped(_ sender: UIButton) {
        viewModel.showOrange()
    }
    
    @IBAction func greenTapped(_ sender: UIButton) {
        viewModel.showGreen()
    }
    
    @IBAction func createProfileTapped(_ sender: UIButton) {
        viewModel.showCreateProfile()
    }
}

extension DecisionVC: StoryboardLoadable {
    static public var storyboardName: String { "Main" }
    static public var identification: StoryboardIdentification { "DecisionVC" }
}

