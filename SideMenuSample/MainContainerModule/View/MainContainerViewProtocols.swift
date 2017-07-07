//
//  MainContainerViewProtocols.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 30/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

// Presenter to View
protocol MainContainerViewInput: class {
    var viewOutput: MainContainerViewOutput? { get set }
}

// View to Presenter
protocol MainContainerViewOutput: class {
    weak var delegate: MainContainerModuleDelegate? { get set }
    func viewDidLoad()
    func menuButtonTapped()
    func handleLeftScreenEdgePan(for gestureRecognizer: UIScreenEdgePanGestureRecognizer)
}
