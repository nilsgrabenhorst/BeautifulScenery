//
//  Scene.swift
//  
//
//  Created by nils.grabenhorst on 18.06.22.
//

import UIKit

/// A `scene` conforming to `Presentable` can be presented modally
public protocol Presentable where Self: SceneFactory {}

/// A `Scene` conforming to `Pushable` can be pushed on a navigation stack
public protocol Pushable where Self: SceneFactory {}

public typealias Showable = Presentable & Pushable

/// Assembles a `UIViewController` and its `Coordinator` & `ViewModel`
///
/// Making the `SceneFactory` a separate type is more flexible than having the `ViewController` or `Coordinator` assume
/// the responsibility of assembling the pieces of a scene.
///
/// I tried using the `Coordinator` to create the scene graph. This is awkward, because the coordinator is owned by its `UIViewController`, so
/// there is only a weak relationship to the view controller.
///
/// I tried having the `UIViewController` creating the scene graph. This is more natural, because the viewController already has ownership of
/// its `viewModel` and `coordinator`. It falls apart as soon as we want to provide an input argument for the scene. The argument should usually
/// be passed to the view model. But if we instantiate a viewController, it needs knowledge about that argument in order to pass it on to the view model. Except,
/// the knowledge of that argument should not be leaked into the view controller.
///
/// The solution for now is to have a factory that creates the scene.
public protocol SceneFactory {
    associatedtype VC: UIViewController
    
    var viewController: VC { get }
}
