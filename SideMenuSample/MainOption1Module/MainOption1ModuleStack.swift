//
//  MainOption1ModuleStack.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 07/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit
import ViperSideDrawer

class MainOption1DataManager {
    fileprivate (set) weak var dataManagerOutput: MainOption1DataManagerOutput?
}

class MainOption1Interactor {
    fileprivate (set) var dataManagerInput: MainOption1DataManagerInput
    fileprivate (set) weak var interactorOutput: MainOption1InteractorOutput?

    fileprivate init(dataManager: MainOption1DataManagerInput = MainOption1DataManager()) {
        self.dataManagerInput = dataManager
    }
}

class MainOption1Presenter {
    weak var delegate: MainOption1ModuleDelegate?

    private (set) var router: MainOption1Router
    private (set) var interactor: MainOption1InteractorInput
    fileprivate (set) weak var view: MainOption1ViewInput?

    fileprivate init(interactor: MainOption1Interactor, router: MainOption1Router) {
        self.interactor = interactor
        self.router          = router
    }
}

class MainOption1Router {
    private (set) weak var viewController: MainOption1ViewController?
    private init() {}

    static let storyboardName = "MainOption1"
    static let viewControllerType = String(describing: MainOption1ViewController.self)
    static let storyboardID = viewControllerType + "ID"

    // MARK: instantiation of module
    static func instantiateModule() -> MainOption1ViewController? {

        guard (Bundle.main.path(forResource: storyboardName, ofType: "storyboardc") != nil) else {
            print("Could not find path for resource \(storyboardName).storyboard")
            return nil
        }
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let storyboardValues = storyboard.value(forKey: "identifierToNibNameMap") as? [String : Any], (storyboardValues[storyboardID] != nil) else {
            print("Could not find ViewController with identifier \(storyboardID) in \(storyboardName).storyboard")
            return nil
        }
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardID) as? MainOption1ViewController else {
            print("ViewController with identifier \(storyboardID) in \(storyboardName).storyboard is not of type \(viewControllerType)")
            return nil
        }

        let router      = MainOption1Router()
        let dataManager = MainOption1DataManager()
        let interactor  = MainOption1Interactor(dataManager: dataManager)
        let presenter   = MainOption1Presenter(interactor: interactor, router: router)

        router.viewController = vc
        presenter.view   = vc
        vc.viewOutput                 = presenter
        interactor.interactorOutput   = presenter
        dataManager.dataManagerOutput = interactor
        return vc
    }
}
