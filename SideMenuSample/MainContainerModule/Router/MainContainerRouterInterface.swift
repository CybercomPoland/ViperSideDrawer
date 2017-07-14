//
//  MainContainerRouterInterface.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 30/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit
import ViperSideDrawer

// Presenter to Router
protocol MainContainerRouterInterface: class {
    func presentSideMenu(with delegate: SideMenuModuleDelegate?)
    func embedInitialModule()
    func embedModule1()
    func embedModule2()
}
