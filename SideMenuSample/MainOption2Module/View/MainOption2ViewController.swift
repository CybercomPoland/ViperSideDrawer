//
//  MainOption2ViewController.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 07/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

class MainOption2ViewController: UIViewController {
    var viewOutput: MainOption2ViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutput?.viewDidLoad()
    }

}

extension MainOption2ViewController: MainOption2ViewInput {

}
