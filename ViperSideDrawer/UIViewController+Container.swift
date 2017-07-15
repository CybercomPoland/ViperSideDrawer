//
//  UIViewController+Container.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 12/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

public extension UIViewController {
    func embed(childViewController childVC: UIViewController) {

        // Remove
        for vc in self.childViewControllers {
            if vc != childVC {
                vc.willMove(toParentViewController: nil)
                vc.view.removeFromSuperview()
                vc.removeFromParentViewController()
            }
        }


        addChildViewController(childVC)

        childVC.view.frame = self.view.bounds
        self.view.addSubview(childVC.view)

        NSLayoutConstraint.activate([childVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     childVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     childVC.view.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     childVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        childVC.didMove(toParentViewController: self)
    }
}
