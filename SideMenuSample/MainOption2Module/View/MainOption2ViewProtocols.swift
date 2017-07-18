//
//  MainOption2ViewProtocols.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 07/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import Foundation

// Presenter to View
protocol MainOption2ViewInput: class {
    var viewOutput: MainOption2ViewOutput? { get set }
}

// View to Presenter
protocol MainOption2ViewOutput: class {
    weak var delegate: MainOption2ModuleDelegate? { get set }
    func viewDidLoad()
    func menuButtonTapped()
}
