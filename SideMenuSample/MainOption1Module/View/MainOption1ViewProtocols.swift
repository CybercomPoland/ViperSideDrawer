//
//  MainOption1ViewProtocols.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 07/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import Foundation

// Presenter to View
protocol MainOption1ViewInput: class {
    var viewOutput: MainOption1ViewOutput? { get set }
}

// View to Presenter
protocol MainOption1ViewOutput: class {
    weak var delegate: MainOption1ModuleDelegate? { get set }
    func viewDidLoad()
}
