//
//  MainOption1ViewController.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 07/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

class MainOption1ViewController: UIViewController {
    var viewOutput: MainOption1ViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutput?.viewDidLoad()
    }

}

extension MainOption1ViewController: MainOption1ViewInput {

}
