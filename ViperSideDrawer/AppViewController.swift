//
//  AppViewController.swift
//  ViperSideDrawer
//
//  Created by Maciej Kucharski on 24/07/2018.
//  Copyright © 2018 Cybercom. All rights reserved.
//

import UIKit

public class AppViewController: UIViewController {

    private var _isBehindStatusBar = false
    var isBehindStatusBar: Bool {
        get {
            return _isBehindStatusBar
        }
        set {
            _isBehindStatusBar = newValue
            updateView(withStatusBarHeight: UIApplication.shared.statusBarFrame.height)
        }
    }
    
    let appView: UIView = UIView()
    
    private var appViewLeadingAnchor: NSLayoutConstraint!
    private var appViewTrailingAnchor: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    private var topConstraint: NSLayoutConstraint!
    
    private var topAnimation: UIViewPropertyAnimator?
    private var bottomAnimation: UIViewPropertyAnimator?
    
    private func updateView(withStatusBarHeight statusBarHeight: CGFloat) {
        
        if appView.frame.size == CGSize.zero && appView.frame.origin == CGPoint.zero {
            return
        }
        
        var topDistance: CGFloat = 0
        if view.frame.origin.y > 0 && statusBarHeight > view.frame.origin.y {
            topDistance = statusBarHeight - view.frame.origin.y
        } else {
            topDistance = isBehindStatusBar ? 0 : statusBarHeight
        }
        let height = view.frame.size.height - topDistance
        
        topAnimation?.stopAnimation(true)
        bottomAnimation?.stopAnimation(true)
        
        topAnimation = UIViewPropertyAnimator(duration: 0.3, curve: .linear, animations: {
            [weak self] in
            self?.topConstraint.constant = topDistance
            self?.view.layoutIfNeeded()
        })
        bottomAnimation = UIViewPropertyAnimator(duration: 0.3, curve: self.isBehindStatusBar ? .easeOut : .easeIn, animations: {
            [weak self] in
            self?.bottomConstraint.constant = height
            self?.view.layoutIfNeeded()
        })
        topAnimation?.startAnimation()
        bottomAnimation?.startAnimation()
    }
    
    @objc func moveStuff() {
        isBehindStatusBar = !isBehindStatusBar
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // TO DEL
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(moveStuff), userInfo: nil, repeats: true)
        
        //
        
//        NotificationCenter.default.addObserver(self, selector: #selector(statusBarWillChange), name:.UIApplicationWillChangeStatusBarFrame, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(statusBarDidChange), name:.UIApplicationDidChangeStatusBarFrame, object: nil)
        
        bottomConstraint = NSLayoutConstraint(item: appView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height)
        topConstraint = NSLayoutConstraint(item: appView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIApplication.shared.statusBarFrame.height)
        appViewLeadingAnchor = appView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        appViewTrailingAnchor = appView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        appView.backgroundColor = UIColor.white
        view.addSubview(appView)

        appView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([appViewLeadingAnchor,
                                     appViewTrailingAnchor,
                                     topConstraint,
                                     bottomConstraint])
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.shared.keyWindow?.backgroundColor = appView.backgroundColor
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        updateView(withStatusBarHeight: UIApplication.shared.statusBarFrame.height)
    }
    
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { context in
            self.updateView(withStatusBarHeight: size.height)
        }, completion: nil)
    }
    
    override public func addChildViewController(_ childController: UIViewController) {
        super.addChildViewController(childController)
        
        appView.addSubview(childController.view)
        
        NSLayoutConstraint.activate([childController.view.leadingAnchor.constraint(equalTo: appView.leadingAnchor),
                                     childController.view.trailingAnchor.constraint(equalTo: appView.trailingAnchor),
                                     childController.view.topAnchor.constraint(equalTo: appView.topAnchor),
                                     childController.view.bottomAnchor.constraint(equalTo: appView.bottomAnchor)])
        appView.layoutIfNeeded()
    }
    
    func slideAppView(distance: CGFloat, animated: Bool = false) {
        
        let animationDuration = animated ? 0.3 : 0.01
        
        self.appViewLeadingAnchor.constant = distance;
        self.appViewTrailingAnchor.constant = distance;
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}
