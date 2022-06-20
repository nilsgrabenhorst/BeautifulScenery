//
//  Configurable.swift
//  
//
//  Created by nils.grabenhorst on 20.06.22.
//

public protocol Configurable {}

public extension Configurable where Self: AnyObject {
    func configure(_ configure: (Self) -> ()) -> Self {
        configure(self)
        return self
    }
}

#if canImport(UIKit)
import UIKit
extension UIViewController: Configurable {}
#endif
