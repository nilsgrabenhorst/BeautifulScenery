//
//  Coordinated.swift
//  
//
//  Created by nils.grabenhorst on 20.06.22.
//

import UIKit

/// A ViewController with a Coordinator
///
/// The viewController owns the `Coordinator`.
public protocol Coordinated: UIViewController {
    associatedtype C: Coordinator
    var coordinator: C! { get set }
}

public extension Coordinated {
    /// Add a `coordinator` object to `self` and set `self` as the owner of the `coordinator`
    /// - Parameter coordinator: The coordinator to add
    /// - Returns: `self`
    @available(iOS 13.0.0, *)
    @discardableResult
    func coordinator(_ coordinator: C) -> Self where C.Owner == Self {
        coordinator.owner = self
        self.coordinator = coordinator
        return self
    }
}
