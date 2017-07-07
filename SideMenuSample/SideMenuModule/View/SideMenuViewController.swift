//
//  SideMenuViewController.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 30/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    var viewOutput: SideMenuViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutput?.viewDidLoad()
    }
}

extension SideMenuViewController: SideMenuViewInput {

}
