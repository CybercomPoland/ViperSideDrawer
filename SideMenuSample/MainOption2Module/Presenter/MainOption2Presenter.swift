//
//  MainOption2Presenter.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 07/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import Foundation
import ViperSideDrawer

class MainOption2Presenter: MenuOptionInterface {
    weak var delegate: MainOption2ModuleDelegate?
    weak var menuOptionDelegate: MenuOptionDelegate?
    
    private (set) var router: MainOption2Router
    private (set) var interactor: MainOption2InteractorInput
    private (set) weak var view: MainOption2ViewInput?

    init(interactor: MainOption2Interactor, router: MainOption2Router, view: MainOption2ViewController) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension MainOption2Presenter: MainOption2InteractorOutput {

}

extension MainOption2Presenter: MainOption2ViewOutput {
    func menuButtonTapped() {
        menuOptionDelegate?.didRequestToShowMenu()
    }

    func viewDidLoad() {}
}
