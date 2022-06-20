//
//  CoordinatedViewController.swift
//  
//
//  Created by Nils Grabenhorst on 19.06.22.
//

import UIKit

public class CoordinatedViewController<CType: Coordinator>: UIViewController, Coordinated {
    public var coordinator: CType!
}
