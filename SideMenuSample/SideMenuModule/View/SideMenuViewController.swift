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

    @IBAction func option1Tapped(_ sender: Any) {
        viewOutput?.didTapButton(at: 0)
    }

    @IBAction func option2Tapped(_ sender: Any) {
        viewOutput?.didTapButton(at: 1)
    }
}

extension SideMenuViewController: SideMenuViewInput {

}
