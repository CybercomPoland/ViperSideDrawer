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
    private (set) weak var view: MainContainerViewController?
    fileprivate let swipeInteractionController = SwipeInteractionController()

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
        self.router.embedInitialModule(in: self)
    }

    func handleLeftScreenEdgePan(for gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        guard let view = view?.view else { return }
        let translation = gestureRecognizer.translation(in: view)
        let progress = TransitionHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .right)
        TransitionHelper.translateGestureToInteractor(gestureRecognizer.state, progress: progress, percentThreshold: 0.3, interactor: swipeInteractionController) {
            self.router.presentSideMenu(with: self, swipeInteractor: swipeInteractionController)
        }
    }

    func menuButtonTapped() {
        self.router.presentSideMenu(with: self, swipeInteractor: nil)
    }
}

extension MainContainerPresenter: SideMenuModuleDelegate {
    func sideMenuDidSelectOption(at index: UInt) {
        guard let sideMenuOption = SideMenuOption(rawValue: index) else { return }

        switch sideMenuOption {
        case .one:
            self.router.embedModule1(in: self)
        case .two:
            self.router.embedModule2(in: self)
        }
    }
}

extension MainContainerPresenter: MenuOptionDelegate {

    func didRequestToShowMenu() {
        self.router.presentSideMenu(with: self, swipeInteractor: nil)
    }

    func show(menuOptionView: UIViewController) {
        self.view?.embed(childViewController: menuOptionView)
    }
}

enum SideMenuOption: UInt {
    case one
    case two
}
