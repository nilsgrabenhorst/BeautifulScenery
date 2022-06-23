//
//  Coordinator.swift
//
//
//  Created by nils.grabenhorst on 18.06.22.
//

import UIKit

@available(iOS 13.0, *)
public var defaultPresentationStyle: UIModalPresentationStyle = .automatic
public var defaultTransitionStyle: UIModalTransitionStyle = .coverVertical

/// A Coordinator
///
/// `Coordinator`s are responsible for deciding when and how to present a new scene.
///
/// The owner of the coordinator must be a  `UIViewController` that conforms to `Coordinated`.
public protocol Coordinator: Owned where Owner: Coordinated {
    typealias VC = Owner
}

public extension Coordinator {
    /// This is also the `owner` of this `Coordinator`
    ///
    /// - warning: The owner is explicitly unwrapped. Make sure it is available before using this property.
    var viewController: VC { owner! }
}

public extension Coordinator {
    
    @available(iOS 13.0, *)
    func present<NextScene: SceneFactory & Presentable>(presentationStyle: UIModalPresentationStyle = defaultPresentationStyle,
                                                        transitionStyle: UIModalTransitionStyle = defaultTransitionStyle,
                                                        animated: Bool = true,
                                                        _ next: NextScene) {
        let nextViewController = next.viewController
        nextViewController.modalPresentationStyle = presentationStyle
        nextViewController.modalTransitionStyle = transitionStyle
        viewController.present(nextViewController, animated: animated)
    }
    
    @available(iOS 13.0, *)
    func show<NextScene: SceneFactory & Presentable>(presentationStyle: UIModalPresentationStyle = defaultPresentationStyle,
                                                     transitionStyle: UIModalTransitionStyle = defaultTransitionStyle,
                                                     _ next: NextScene) {
        present(presentationStyle: presentationStyle, transitionStyle: transitionStyle, next)
    }
}

public extension Coordinator where Self: Pushable {
    var navigationController: UINavigationController? {
        viewController.navigationController
    }
    
    func push<NextScene: SceneFactory & Pushable>(animated: Bool = true,
                                                  _ next: NextScene) {
        guard let navigationController = viewController.navigationController else {
            fatalError("\(type(of: self)) cannot push because host '\(type(of: self.viewController))' has no navigationController")
        }
        let nextViewController = next.viewController
        navigationController.pushViewController(nextViewController, animated: animated)
    }
    
    @available(iOS 13.0, *)
    func show<NextScene: SceneFactory & Pushable>(presentationStyle: UIModalPresentationStyle = defaultPresentationStyle,
                                                  transitionStyle: UIModalTransitionStyle = defaultTransitionStyle,
                                                  _ next: NextScene) {
        push(next)
    }
    
    @available(iOS 13.0, *)
    func show<NextScene: SceneFactory & Pushable & Presentable>(presentationStyle: UIModalPresentationStyle = defaultPresentationStyle,
                                                 transitionStyle: UIModalTransitionStyle = defaultTransitionStyle,
                                                                _ next: NextScene) {
        guard viewController.navigationController != nil else {
            return present(presentationStyle: presentationStyle, transitionStyle: transitionStyle, next)
        }
        return push(next)
    }
    
    func dismiss(animated: Bool = true) {
        guard let navigationController = navigationController else {
            viewController.parent?.dismiss(animated: animated)
            return
        }
        navigationController.dismiss(animated: animated)
    }
}
