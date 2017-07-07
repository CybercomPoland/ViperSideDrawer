//
//  SideMenuRouter.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 30/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

extension SideMenuRouter: SideMenuRouterInterface {
    func dismissUserInterface() {
        self.viewController?.dismiss(animated: true, completion: nil)
    }
}
