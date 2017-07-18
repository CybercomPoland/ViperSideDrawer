//
//  MainOption2ModuleStack.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 07/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit
import ViperSideDrawer

class MainOption2DataManager {
    fileprivate (set) weak var dataManagerOutput: MainOption2DataManagerOutput?
}

class MainOption2Interactor {
    fileprivate (set) var dataManagerInput: MainOption2DataManagerInput
    fileprivate (set) weak var interactorOutput: MainOption2InteractorOutput?

    fileprivate init(dataManager: MainOption2DataManagerInput = MainOption2DataManager()) {
        self.dataManagerInput = dataManager
    }
}

class MainOption2Router {
    private (set) weak var viewController: MainOption2ViewController?
    private init() {}

    static let storyboardName = "MainOption2"
    static let viewControllerType = String(describing: MainOption2ViewController.self)
    static let storyboardID = viewControllerType + "ID"

    // MARK: instantiation of module
    static func instantiateModule(withDelegate delegate: MenuOptionDelegate) -> UIViewController? {

        guard (Bundle.main.path(forResource: storyboardName, ofType: "storyboardc") != nil) else {
            print("Could not find path for resource \(storyboardName).storyboard")
            return nil
        }

        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let storyboardValues = storyboard.value(forKey: "identifierToNibNameMap") as? [String : Any], (storyboardValues[storyboardID] != nil) else {
            print("Could not find ViewController with identifier \(storyboardID) in \(storyboardName).storyboard")
            return nil
        }

        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardID) as? MainOption2ViewController else {
            print("ViewController with identifier \(storyboardID) in \(storyboardName).storyboard is not of type \(viewControllerType)")
            return nil
        }

        let router      = MainOption2Router()
        let dataManager = MainOption2DataManager()
        let interactor  = MainOption2Interactor(dataManager: dataManager)
        let presenter   = MainOption2Presenter(interactor: interactor, router: router, view: vc)

        presenter.menuOptionDelegate = delegate
        router.viewController = vc
        vc.viewOutput                 = presenter
        interactor.interactorOutput   = presenter
        dataManager.dataManagerOutput = interactor
        let navigationController = UINavigationController(rootViewController: vc)
        return navigationController
    }
}
