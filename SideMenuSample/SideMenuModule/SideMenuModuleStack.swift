//
//  SideMenuModuleStack.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 30/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit
import ViperSideDrawer

class SideMenuDataManager {
    fileprivate (set) weak var dataManagerOutput: SideMenuDataManagerOutput?
}

class SideMenuInteractor {
    fileprivate (set) var dataManagerInput: SideMenuDataManagerInput
    fileprivate (set) weak var interactorOutput: SideMenuInteractorOutput?

    fileprivate init(dataManager: SideMenuDataManagerInput = SideMenuDataManager()) {
        self.dataManagerInput = dataManager
    }
}

class SideMenuPresenter {
    weak var delegate: SideMenuModuleDelegate?

    private (set) var router: SideMenuRouter
    private (set) var interactor: SideMenuInteractorInput
    fileprivate (set) weak var view: SideMenuViewInput?

    fileprivate init(interactor: SideMenuInteractor, router: SideMenuRouter) {
        self.interactor = interactor
        self.router          = router
    }
}

class SideMenuRouter {
    private (set) weak var viewController: SideMenuViewController?
    private init() {}

    static let storyboardName = "SideMenu"
    static let viewControllerType = String(describing: SideMenuViewController.self)
    static let storyboardID = viewControllerType + "ID"

    var slideInPresentationManager: SlideInPresentationManager?

    // MARK: instantiation of module
    static func instantiateModule(with delegate: SideMenuModuleDelegate?) -> SideMenuViewController? {

        guard (Bundle.main.path(forResource: storyboardName, ofType: "storyboardc") != nil) else {
            print("Could not find path for resource \(storyboardName).storyboard")
            return nil
        }
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let storyboardValues = storyboard.value(forKey: "identifierToNibNameMap") as? [String : Any], (storyboardValues[storyboardID] != nil) else {
            print("Could not find ViewController with identifier \(storyboardID) in \(storyboardName).storyboard")
            return nil
        }

        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardID) as? SideMenuViewController else {
            print("ViewController with identifier \(storyboardID) in \(storyboardName).storyboard is not of type \(viewControllerType)")
            return nil
        }

        let presentationManager = SlideInPresentationManager(widthRatio: 5/6, type: .reveal, direction: .left)

        let router      = SideMenuRouter()
        router.slideInPresentationManager = presentationManager

        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = presentationManager

        let dataManager = SideMenuDataManager()
        let interactor  = SideMenuInteractor(dataManager: dataManager)
        let presenter   = SideMenuPresenter(interactor: interactor, router: router)
        presenter.delegate = delegate

        router.viewController = vc
        presenter.view   = vc
        vc.viewOutput                 = presenter
        interactor.interactorOutput   = presenter
        dataManager.dataManagerOutput = interactor
        return vc
    }

    static func presentUserInterface(from parentViewController: UIViewController?, with delegate: SideMenuModuleDelegate?) {
        guard let viewController = self.instantiateModule(with: delegate) else {return}

        parentViewController?.present(viewController, animated: true, completion: nil)
    }
}
