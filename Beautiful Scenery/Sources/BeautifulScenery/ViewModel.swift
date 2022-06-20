//
//  ViewModel.swift
//  
//
//  Created by nils.grabenhorst on 18.06.22.
//

import Foundation
import UIKit

public protocol ViewModel: Owned where Owner: ViewModeled {
    typealias VC = Owner
}

public extension ViewModel {
    // just renaming `owner` to make it more developer-friendly
    var viewController: VC { owner! }
}

public extension ViewModel where Owner: Coordinated {
    var coordinator: VC.C {
        viewController.coordinator
    }
}

public protocol ViewModeled: AnyObject {
    associatedtype VM: ViewModel where VM.VC == Self
    var viewModel: VM! { get set }
}

public extension ViewModeled {
    @available(iOS 13.0.0, *)
    @discardableResult
    func viewModel(_ viewModel: VM) -> Self {
        viewModel.owner = self
        self.viewModel = viewModel
        return self
    }
}

@propertyWrapper
public struct Indirect<Value: Coordinator> {
    public init() {}

    public static subscript<VM: ViewModel> (
        _enclosingInstance instance: VM,
        wrapped wrappedKeyPath: KeyPath<VM, Value>,
        storage storageKeyPath: KeyPath<VM, Self>
    ) -> Value where Value.VC == VM.VC, VM.VC.C == Value {
        get {
            instance.viewController.coordinator
        }
    }

    @available(*, unavailable, message: "@Published can only be applied to classes")
    public var wrappedValue: Value {
        get { fatalError() }
    }
}
