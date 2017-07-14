//
//  SideMenuViewProtocols.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 30/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import Foundation

// Presenter to View
protocol SideMenuViewInput: class {
    var viewOutput: SideMenuViewOutput? { get set }
}

// View to Presenter
protocol SideMenuViewOutput: class {
    func viewDidLoad()
    func didTapButton(at index: UInt)
}
