//
//  GreenViewController.swift
//  CoordinatorTrainingGround
//
//  Created by nils.grabenhorst on 16.06.22.
//

import UIKit
import BeautifulScenery

struct GreenScene: Scene, Presentable {
    var viewController: some Coordinated {
        GreenViewController()
            .coordinator(.init())
            .configure { $0.view.backgroundColor = .green }
    }
}

class GreenViewController: UIViewController, Coordinated {
    public var coordinator: GreenCoordinator!
}

class GreenCoordinator: Coordinator, Showable {
    weak var owner: GreenViewController?
}
