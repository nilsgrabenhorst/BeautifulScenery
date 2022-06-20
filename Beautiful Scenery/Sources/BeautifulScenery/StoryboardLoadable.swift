//
//  StoryboardLoadable.swift
//  
//
//  Created by nils.grabenhorst on 18.06.22.
//

import UIKit

public protocol Loadable {
    static func instantiate() -> Self
}

public enum StoryboardIdentification: ExpressibleByStringLiteral {
    case initialViewController
    case identifier(String)
    
    public init(stringLiteral value: StringLiteralType) {
        self = .identifier(value)
    }
}

public protocol StoryboardLoadable: Loadable where Self: UIViewController {
    static var storyboardBundle: Bundle { get }
    static var storyboardName: String { get }
    static var storyboard: UIStoryboard { get }
    static var identification: StoryboardIdentification { get }
}

public extension StoryboardLoadable {
    static var storyboardBundle: Bundle {
        Bundle.main
    }
    
    static var identification: StoryboardIdentification {
        .initialViewController
    }
    
    static var storyboard: UIStoryboard {
        UIStoryboard(name: storyboardName, bundle: storyboardBundle)
    }
    
    static func instantiate() -> Self {
        switch identification {
        case .initialViewController:
            return storyboard.instantiateInitialViewController() as! Self
            
        case .identifier(let id):
            return storyboard.instantiateViewController(withIdentifier: id) as! Self
        }
    }
}
