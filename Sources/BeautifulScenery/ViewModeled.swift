//
//  ViewModeled.swift
//  
//
//  Created by nils.grabenhorst on 20.06.22.
//

import UIKit

/// An object with a `ViewModel`
public protocol ViewModeled: UIViewController {
    associatedtype VM: ViewModel where VM.VC == Self
    var viewModel: VM! { get set }
}

public extension ViewModeled {
    /// Add a `viewModel` object to `self` and set `self` as the owner of the `viewModel`
    /// - Parameter viewModel: The viewModel to add
    /// - Returns: `self`
    @available(iOS 13.0.0, *)
    @discardableResult
    func viewModel(_ viewModel: VM) -> Self {
        viewModel.owner = self
        self.viewModel = viewModel
        return self
    }
}
