//
//  MainContainerViewController.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 30/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

class MainContainerViewController: UIViewController {
    var viewOutput: MainContainerViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutput?.viewDidLoad()
        setUpGestureRecognizers()
    }

    // MARK: - Private
    func setUpNavigationBar() {
        let menuBarButton = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.leftBarButtonItem = menuBarButton
    }

    @objc func menuButtonTapped() {
        viewOutput?.menuButtonTapped()
    }

    func setUpGestureRecognizers() {
        let leftEdgeSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(for:)))
        leftEdgeSwipe.edges = .left
        view.addGestureRecognizer(leftEdgeSwipe)
    }

    @objc func handleGesture(for gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        viewOutput?.handleLeftScreenEdgePan(for: gestureRecognizer)
    }
}

extension MainContainerViewController: MainContainerViewInput {

}
