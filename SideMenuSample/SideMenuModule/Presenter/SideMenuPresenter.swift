//
//  SideMenuPresenter.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 30/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import Foundation
import ViperSideDrawer

class SideMenuPresenter {
    weak var delegate: SideMenuModuleDelegate?

    private (set) var router: SideMenuRouter
    private (set) var interactor: SideMenuInteractorInput
    private (set) weak var view: SideMenuViewInput?

    init(interactor: SideMenuInteractor, router: SideMenuRouter, view: SideMenuViewController) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension SideMenuPresenter: SideMenuInteractorOutput {

}

extension SideMenuPresenter: SideMenuViewOutput {

    func viewDidLoad() {

    }

    func didTapButton(at index: UInt) {
        delegate?.sideMenuDidSelectOption(at: index)
        router.dismissUserInterface()
    }
}

