//
//  SelectAvatar.swift
//  CoordinatorTrainingGround
//
//  Created by Nils Grabenhorst on 19.06.22.
//

import UIKit
import BeautifulScenery

struct SelectAvatar: Scene, Pushable {
    var viewController: some Coordinated {
        SelectAvatarViewController.instantiate()
            .coordinator(SelectAvatarCoordinator())
    }
}

class SelectAvatarViewController: UIViewController, Coordinated, StoryboardLoadable {
    static let storyboardName = "SelectAvatarViewController"
    var coordinator: SelectAvatarCoordinator!
}

class SelectAvatarCoordinator: Coordinator, Pushable {
    weak var owner: SelectAvatarViewController?
}
