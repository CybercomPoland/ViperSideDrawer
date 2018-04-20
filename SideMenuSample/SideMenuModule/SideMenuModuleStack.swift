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

class SideMenuRouter {
    private (set) weak var viewController: SideMenuViewController?
    private init() {}

    static let storyboardName = "SideMenu"
    static let viewControllerType = String(describing: SideMenuViewController.self)
    static let storyboardID = viewControllerType + "ID"

    static let slideInPresentationWidthRatio: CGFloat = 5/6
    static let slideInPresentationType = SideDrawerPresentationType.reveal
    static let slideInPresentationDirection = SideDrawerPresentationDirection.left

    var slideInPresentationManager: SlideInPresentationManager?

    // MARK: instantiation of module
    static func instantiateModule(with delegate: SideMenuModuleDelegate?, percentInteractiveTransition: PercentInteractiveTransition?) -> SideMenuViewController? {

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

        let presentationManager = SlideInPresentationManager(widthRatio: slideInPresentationWidthRatio,
                                                             type: slideInPresentationType,
                                                             direction: slideInPresentationDirection,
                                                             interactiveTransition: percentInteractiveTransition)

        let router      = SideMenuRouter()
        router.slideInPresentationManager = presentationManager

        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = presentationManager

        let dataManager = SideMenuDataManager()
        let interactor  = SideMenuInteractor(dataManager: dataManager)
        let presenter   = SideMenuPresenter(interactor: interactor, router: router, view: vc)
        presenter.delegate = delegate

        router.viewController = vc
        vc.viewOutput                 = presenter
        interactor.interactorOutput   = presenter
        dataManager.dataManagerOutput = interactor
        return vc
    }

    static func presentUserInterface(from parentViewController: UIViewController?, with delegate: SideMenuModuleDelegate?, percentInteractiveTransition: PercentInteractiveTransition?) {
        guard let viewController = instantiateModule(with: delegate, percentInteractiveTransition: percentInteractiveTransition) else {return}

        parentViewController?.present(viewController, animated: true, completion: nil)
    }
}
