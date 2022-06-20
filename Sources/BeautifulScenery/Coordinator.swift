//
//  Coordinator.swift
//
//
//  Created by nils.grabenhorst on 18.06.22.
//

import UIKit

public protocol Coordinator: Owned where Owner: Coordinated {
    typealias VC = Owner
}

public extension Coordinator {
    // just renaming `owner` to make it more developer-friendly
    var viewController: VC { owner! }
}

public protocol Coordinated: UIViewController {
    associatedtype C: Coordinator // where C.VC == Self
    var coordinator: C! { get set }
}

public protocol Presentable {}

public protocol Pushable {}

public typealias Showable = Presentable & Pushable

public extension Coordinator {
    
    func present<T: Scene & Presentable>(_ next: T, animated: Bool = true) {
        viewController.present(next.viewController, animated: animated)
    }
    
    func show<T: Scene & Presentable>(_ next: T) {
        present(next)
    }
}

public extension Coordinator where Self: Pushable {
    func push<T: Scene & Pushable>(_ next: T, animated: Bool = true) {
        guard let navigationController = viewController.navigationController else {
            fatalError("\(type(of: self)) cannot push because host '\(type(of: self.viewController))' has no navigationController")
        }
        navigationController.pushViewController(next.viewController, animated: animated)
    }
    
    // TODO: only push next if Self is in a navigation context
    func show<T: Scene & Pushable>(_ next: T) {
        push(next)
    }
}

public extension Coordinated {
    @available(iOS 13.0.0, *)
    @discardableResult
    func coordinator(_ coordinator: C) -> Self where C.Owner == Self {
        coordinator.owner = self
        self.coordinator = coordinator
        return self
    }
}
