//
//  MainOption2Router.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 07/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

extension MainOption2Router: MainOption2RouterInterface {

    static func embed(in parentViewController: UIViewController) {
        guard let vc = MainOption2Router.instantiateModule() else { return }
        parentViewController.embed(childViewController: vc)
    }

}
