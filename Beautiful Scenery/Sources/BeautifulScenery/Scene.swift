//
//  Scene.swift
//  
//
//  Created by nils.grabenhorst on 18.06.22.
//

import UIKit

public protocol Scene {
    associatedtype VC: UIViewController
    
    var viewController: VC { get }
}

public protocol Configurable {}

public extension Configurable where Self: AnyObject {
    func configure(_ configure: (Self) -> ()) -> Self {
        configure(self)
        return self
    }
}

extension UIViewController: Configurable {}

@available(iOS 13.0.0, *)
public extension Scene {
    func navigationRoot() -> some Scene & Presentable {
        NavigationRoot(self)
    }
}
