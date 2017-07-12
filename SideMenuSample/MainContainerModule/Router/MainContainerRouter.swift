//
//  MainContainerRouter.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 30/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

extension MainContainerRouter: MainContainerRouterInterface {

    func presentSideMenu() {
        SideMenuRouter.presentUserInterface(from: self.viewController)
    }

    func embedInitialModule() {
        guard let vc = self.viewController else { return }
        MainOption1Router.embed(in: vc)
    }
}
