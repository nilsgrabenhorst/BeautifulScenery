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
    func present<T: SceneFactory & Presentable>(presentationStyle: UIModalPresentationStyle = defaultPresentationStyle,
                                         transitionStyle: UIModalTransitionStyle = defaultTransitionStyle,
                                         animated: Bool = true,
                                         _ next: T) {
        let nextViewController = next.viewController
        nextViewController.modalPresentationStyle = presentationStyle
        nextViewController.modalTransitionStyle = transitionStyle
        viewController.present(nextViewController, animated: animated)
    }
    
    @available(iOS 13.0, *)
    func show<T: SceneFactory & Presentable>(presentationStyle: UIModalPresentationStyle = defaultPresentationStyle,
                                      transitionStyle: UIModalTransitionStyle = defaultTransitionStyle,
                                      _ next: T
    ) {
        present(presentationStyle: presentationStyle, transitionStyle: transitionStyle, next)
    }
}

public extension Coordinator where Self: Pushable {
    func push<T: SceneFactory & Pushable>(animated: Bool = true, _ next: T) {
        guard let navigationController = viewController.navigationController else {
            fatalError("\(type(of: self)) cannot push because host '\(type(of: self.viewController))' has no navigationController")
        }
        navigationController.pushViewController(next.viewController, animated: animated)
    }
    
    @available(iOS 13.0, *)
    func show<T: SceneFactory & Pushable>(presentationStyle: UIModalPresentationStyle = defaultPresentationStyle,
                                   transitionStyle: UIModalTransitionStyle = defaultTransitionStyle,
                                   _ next: T
    ) {
        push(next)
    }
    
    @available(iOS 13.0, *)
    func show<T: SceneFactory & Pushable & Presentable>(presentationStyle: UIModalPresentationStyle = defaultPresentationStyle,
                                                 transitionStyle: UIModalTransitionStyle = defaultTransitionStyle,
                                                 _ next: T
    ) {
        guard viewController.navigationController != nil else {
            present(presentationStyle: presentationStyle, transitionStyle: transitionStyle, next)
            return
        }
        push(next)
    }
}
