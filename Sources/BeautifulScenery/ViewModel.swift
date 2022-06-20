//
//  ViewModel.swift
//  
//
//  Created by nils.grabenhorst on 18.06.22.
//

import Foundation
import UIKit

/// A ViewModel
///
/// The owner of the viewModel must be a  `UIViewController` that conforms to `ViewModeled`.
/// There is a computed `coordinator` property available if the owner is `Coordinated`.
public protocol ViewModel: Owned where Owner: ViewModeled {
    typealias VC = Owner
}

public extension ViewModel {
    /// This is also the `owner` of this `ViewModel`
    ///
    /// - warning: The owner is explicitly unwrapped. Make sure it is available before using this property.
    var viewController: VC { owner! }
}

public extension ViewModel where Owner: Coordinated {
    var coordinator: VC.C {
        viewController.coordinator
    }
}
