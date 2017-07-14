//
//  MainContainerRouter.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 30/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit
import ViperSideDrawer

extension MainContainerRouter: MainContainerRouterInterface {

    func presentSideMenu(with delegate: SideMenuModuleDelegate?) {
        SideMenuRouter.presentUserInterface(from: self.viewController, with: delegate)
    }

    func embedInitialModule() {
        embedModule1()
    }

    func embedModule1() {
        guard let vc = self.viewController else { return }
        MainOption1Router.embed(in: vc)
    }

    func embedModule2() {
        guard let vc = self.viewController else { return }
        MainOption2Router.embed(in: vc)
    }
}
