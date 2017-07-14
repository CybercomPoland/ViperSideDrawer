//
//  MainOption1Router.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 07/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

extension MainOption1Router: MainOption1RouterInterface {
    static func embed(in parentViewController: UIViewController) {
        guard let vc = MainOption1Router.instantiateModule() else { return }
        parentViewController.embed(childViewController: vc)
    }
}
