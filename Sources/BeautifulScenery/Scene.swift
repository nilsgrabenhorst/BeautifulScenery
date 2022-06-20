//
//  Scene.swift
//  
//
//  Created by nils.grabenhorst on 18.06.22.
//

import UIKit

/// A `scene` conforming to `Presentable` can be presented modally
public protocol Presentable where Self: Scene {}

/// A `Scene` conforming to `Pushable` can be pushed on a navigation stack
public protocol Pushable where Self: Scene {}

public typealias Showable = Presentable & Pushable

/// Assembles a `UIViewController` and its `Coordinator` & `ViewModel`
public protocol Scene {
    associatedtype VC: UIViewController
    
    var viewController: VC { get }
}
