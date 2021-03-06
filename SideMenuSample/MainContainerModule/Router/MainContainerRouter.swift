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

    func presentSideMenu(with delegate: SideMenuModuleDelegate?, swipeInteractionController: SwipeInteractionController? = nil) {
        SideMenuRouter.presentUserInterface(from: viewController, with: delegate, percentInteractiveTransition: swipeInteractionController?.percentInteractiveTransition)
    }

    func embedInitialModule(in containerModule: MenuOptionDelegate) {
        embedModule1(in: containerModule)
    }

    func embedModule1(in containerModule: MenuOptionDelegate) {
        MainOption1Router.embed(in: containerModule)
    }

    func embedModule2(in containerModule: MenuOptionDelegate) {
        MainOption2Router.embed(in: containerModule)
    }
}
