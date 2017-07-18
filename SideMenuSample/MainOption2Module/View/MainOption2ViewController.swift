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
        setUpNavigationBar()
        viewOutput?.viewDidLoad()
    }
    
    // MARK: - Private
    func setUpNavigationBar() {
        let menuBarButton = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuButtonTapped))
        self.navigationItem.leftBarButtonItem = menuBarButton
    }

    @objc func menuButtonTapped() {
        self.viewOutput?.menuButtonTapped()
    }

}

extension MainOption2ViewController: MainOption2ViewInput {

}
