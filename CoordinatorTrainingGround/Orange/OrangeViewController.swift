//
//  OrangeViewController.swift
//  CoordinatorTrainingGround
//
//  Created by nils.grabenhorst on 16.06.22.
//

import UIKit
import BeautifulScenery

struct OrangeScene: Scene, Presentable, Pushable {
    var viewController: some Coordinated {
        OrangeViewController()
            .viewModel(.init())
            .coordinator(.init())
            .configure { $0.view.backgroundColor = .orange }
    }
}

class OrangeViewController: UIViewController, Coordinated, ViewModeled {
    var coordinator: OrangeCoordinator!
    var viewModel: OrangeViewModel!

    deinit {
        print("Orange ViewController: K THX BYE!")
    }
}

class OrangeCoordinator: Coordinator, Showable {
    weak var owner: OrangeViewController?

    deinit {
        print("Orange Coordinator: I'm outta here!")
    }
}

class OrangeViewModel: ViewModel {
    weak var owner: OrangeViewController?

    deinit {
        print("Orange ViewModel: So long!")
    }
}

