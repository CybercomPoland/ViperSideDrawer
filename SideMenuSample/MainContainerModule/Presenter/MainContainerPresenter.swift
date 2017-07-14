//
//  MainContainerPresenter.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 30/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit
import ViperSideDrawer

class MainContainerPresenter {
    weak var delegate: MainContainerModuleDelegate?

    private (set) var router: MainContainerRouter
    private (set) var interactor: MainContainerInteractorInput
    private (set) weak var view: MainContainerViewInput?

    init(interactor: MainContainerInteractor, router: MainContainerRouter, view: MainContainerViewController) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension MainContainerPresenter: MainContainerInteractorOutput {

}

extension MainContainerPresenter: MainContainerViewOutput {

    func viewDidLoad() {
        self.router.embedInitialModule()
    }

    func handleLeftScreenEdgePan(for gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
//        let shouldStartTransition = self.swipeInteractionController.shouldStartInteractiveTransition(for: gestureRecognizer)
//        if shouldStartTransition {
//            self.router.presentSideMenu(with: self.swipeInteractionController)
//        }
    }

    func menuButtonTapped() {
        self.router.presentSideMenu(with: self)
    }
}

extension MainContainerPresenter: SideMenuModuleDelegate {
    func sideMenuDidSelectOption(at index: UInt) {
        guard let sideMenuOption = SideMenuOption(rawValue: index) else { return }

        switch sideMenuOption {
        case .one:
            self.router.embedModule1()
        case .two:
            self.router.embedModule2()
        }
    }
}

enum SideMenuOption: UInt {
    case one
    case two
}
