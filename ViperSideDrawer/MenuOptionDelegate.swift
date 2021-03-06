//
//  MenuOptionDelegate.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 16/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

public protocol MenuOptionDelegate: class {
    func show(menuOptionView: UIViewController)
    func didRequestToShowMenu()
}

public protocol MenuOptionInterface: class {
    var menuOptionDelegate: MenuOptionDelegate? { get set }
}

public protocol MenuOptionRouterInterface: class {
    static func embed(in containerModule: MenuOptionDelegate)
}
