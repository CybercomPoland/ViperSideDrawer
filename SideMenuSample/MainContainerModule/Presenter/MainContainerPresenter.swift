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
    fileprivate let swipeInteractionController: SwipeInteractionController

    init(interactor: MainContainerInteractor, router: MainContainerRouter, view: MainContainerViewController, swipeInteractionController: SwipeInteractionController) {
        self.interactor = interactor
        self.router = router
        self.view = view
        self.swipeInteractionController = swipeInteractionController
    }
}

extension MainContainerPresenter: MainContainerInteractorOutput {

}

extension MainContainerPresenter: MainContainerViewOutput {

    func viewDidLoad() {
        router.embedInitialModule(in: self)
    }

    func handleLeftScreenEdgePan(for gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        guard let view = view?.view else { return }
        swipeInteractionController.handleScreenEdgePanGesture (gesture: gestureRecognizer, view: view) {
            router.presentSideMenu(with: self, swipeInteractionController: swipeInteractionController)
        }
    }

    func menuButtonTapped() {
        router.presentSideMenu(with: self)
    }
}

extension MainContainerPresenter: SideMenuModuleDelegate {
    func sideMenuDidSelectOption(at index: UInt) {
        guard let sideMenuOption = SideMenuOption(rawValue: index) else { return }

        switch sideMenuOption {
        case .one:
            router.embedModule1(in: self)
        case .two:
            router.embedModule2(in: self)
        }
    }
}

extension MainContainerPresenter: MenuOptionDelegate {

    func didRequestToShowMenu() {
        router.presentSideMenu(with: self)
    }

    func show(menuOptionView: UIViewController) {
        view?.embed(childViewController: menuOptionView)
    }
}

enum SideMenuOption: UInt {
    case one
    case two
}
