//
//  Owned.swift
//  
//
//  Created by nils.grabenhorst on 18.06.22.
//

import Foundation

public protocol Owned: AnyObject {
    associatedtype Owner
    var owner: Owner? { get set }
}
