//
//  NavigationRoot.swift
//  
//
//  Created by Nils Grabenhorst on 19.06.22.
//

import Foundation
import UIKit

@available(iOS 13.0.0, *)
public struct NavigationRoot<Root: SceneFactory>: SceneFactory, Presentable {
    
    public let root: Root
    
    public init(_ root: Root) {
        self.root = root
    }
    
    public var viewController: some UIViewController {
        UINavigationController(rootViewController: root.viewController)
    }
}
