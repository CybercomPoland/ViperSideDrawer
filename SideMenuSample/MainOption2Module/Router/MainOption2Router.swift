//
//  MainOption2Router.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 07/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit
import ViperSideDrawer

extension MainOption2Router: MainOption2RouterInterface {

    static func embed(in containerModule: MenuOptionDelegate) {
        guard let vc = instantiateModule(withDelegate: containerModule) else { return }
        containerModule.show(menuOptionView: vc)
    }
}
