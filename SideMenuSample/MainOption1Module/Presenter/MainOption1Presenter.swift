//
//  MainOption1Presenter.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 07/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import Foundation
import ViperSideDrawer

class MainOption1Presenter: MenuOptionInterface {
    weak var delegate: MainOption1ModuleDelegate?
    weak var menuOptionDelegate: MenuOptionDelegate?

    private (set) var router: MainOption1Router
    private (set) var interactor: MainOption1InteractorInput
    private (set) weak var view: MainOption1ViewInput?

    init(interactor: MainOption1Interactor, router: MainOption1Router, view: MainOption1ViewController) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension MainOption1Presenter: MainOption1InteractorOutput {

}

extension MainOption1Presenter: MainOption1ViewOutput {
    func menuButtonTapped() {
        self.menuOptionDelegate?.didRequestToShowMenu()
    }


    func viewDidLoad() {}
}
