//
//  SideMenuModuleDelegate.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 07/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import Foundation

protocol SideMenuModuleDelegate {
    var sideMenuModule: SideMenuModuleInterface? { get set }
    func didSelectOption(at index: UInt)
}
