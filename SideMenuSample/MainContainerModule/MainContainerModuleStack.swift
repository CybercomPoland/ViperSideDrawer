//
//  MainContainerModuleStack.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 30/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

class MainContainerDataManager {
    fileprivate (set) weak var dataManagerOutput: MainContainerDataManagerOutput?
}

class MainContainerInteractor {
    fileprivate (set) var dataManagerInput: MainContainerDataManagerInput
    fileprivate (set) weak var interactorOutput: MainContainerInteractorOutput?

    fileprivate init(dataManager: MainContainerDataManagerInput = MainContainerDataManager()) {
        self.dataManagerInput = dataManager
    }
}

class MainContainerRouter {
    private (set) weak var viewController: MainContainerViewController?
    private init() {}

    static let storyboardName = "MainContainer"
    static let viewControllerType = String(describing: MainContainerViewController.self)
    static let storyboardID = viewControllerType + "ID"

    // MARK: instantiation of module
    static func instantiateModule() -> UIViewController? {

        guard (Bundle.main.path(forResource: storyboardName, ofType: "storyboardc") != nil) else {
            print("Could not find path for resource \(storyboardName).storyboard")
            return nil
        }
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let storyboardValues = storyboard.value(forKey: "identifierToNibNameMap") as? [String : Any], (storyboardValues[storyboardID] != nil) else {
            print("Could not find ViewController with identifier \(storyboardID) in \(storyboardName).storyboard")
            return nil
        }
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardID) as? MainContainerViewController else {
            print("ViewController with identifier \(storyboardID) in \(storyboardName).storyboard is not of type \(viewControllerType)")
            return nil
        }

        let router      = MainContainerRouter()
        let dataManager = MainContainerDataManager()
        let interactor  = MainContainerInteractor(dataManager: dataManager)
        let presenter   = MainContainerPresenter(interactor: interactor, router: router, view: vc)

        router.viewController = vc
        vc.viewOutput = presenter
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        return vc
    }
}
