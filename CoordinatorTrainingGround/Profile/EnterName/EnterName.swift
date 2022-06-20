//
//  EnterName.swift
//  CoordinatorTrainingGround
//
//  Created by Nils Grabenhorst on 19.06.22.
//

import UIKit
import BeautifulScenery

struct EnterName: Scene, Pushable {
    var viewController: some Coordinated {
        EnterNameViewController.instantiate()
            .viewModel(EnterNameViewModel())
            .coordinator(EnterNameCoordinator())
    }
}

class EnterNameViewController: UIViewController, Coordinated, ViewModeled, StoryboardLoadable {
    static let storyboardName = "EnterNameViewController"
    
    var coordinator: EnterNameCoordinator!
    var viewModel: EnterNameViewModel!
    
    @IBOutlet private weak var firstNameField: UITextField!
    @IBOutlet private weak var lastNameField: UITextField!
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        viewModel.next(firstName: firstNameField.text, lastName: lastNameField.text)
    }
}

class EnterNameViewModel: ViewModel {
    var owner: EnterNameViewController?
    
    func next(firstName: String?, lastName: String?) {
        print("let's choose an avatar for \(firstName ?? "") \(lastName ?? "")")
        coordinator.next()
    }
}

class EnterNameCoordinator: Coordinator, Pushable {
    weak var owner: EnterNameViewController?
    
    func next() {
        push(
            SelectAvatar()
        )
    }
}
