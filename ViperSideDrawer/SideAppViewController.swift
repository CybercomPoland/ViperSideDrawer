//
//  SideAppViewController.swift
//  ViperSideDrawer
//
//  Created by Maciej Kucharski on 01/08/2018.
//  Copyright © 2018 Cybercom Poland. All rights reserved.
//

import UIKit

public class SideAppViewController: AppViewController {
    
    let sideView: UIView = UIView()
    var sideViewWidth: NSLayoutConstraint!
    
    var interactionInProgress = false
    var interactionShoudFinish = false
    var percentThreshold: CGFloat = 0.3
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        sideView.translatesAutoresizingMaskIntoConstraints = false
        appView.addSubview(sideView)
        
        sideViewWidth = sideView.widthAnchor.constraint(equalToConstant: 200)
        NSLayoutConstraint.activate([sideViewWidth,
                                     sideView.trailingAnchor.constraint(equalTo: appView.leadingAnchor),
                                     sideView.topAnchor.constraint(equalTo: appView.topAnchor),
                                     sideView.bottomAnchor.constraint(equalTo: appView.bottomAnchor)])
        
        setUpGestureRecognizers()
    }
    
    func setUpGestureRecognizers() {
        let leftEdgeSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(for:)))
        leftEdgeSwipe.edges = .left
        appView.addGestureRecognizer(leftEdgeSwipe)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        appView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleGesture(for gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: appView)
        let progress = TransitionHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .right)
        
        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
        case .changed:
            interactionShoudFinish = progress > percentThreshold
            slideAppView(distance: progress * sideViewWidth.constant)
        case .cancelled:
            interactionInProgress = false
            slideAppView(distance: 0, animated: true)
        case .ended:
            interactionInProgress = false
            interactionShoudFinish ? slideAppView(distance: sideViewWidth.constant, animated: true) : slideAppView(distance: 0, animated: true)
        default:
            break
        }
    }
    
    @objc func handleTapGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        slideAppView(distance: 0, animated: true)
    }
    
    public func addSideViewController(_ sideController: UIViewController) {
        sideController.view.translatesAutoresizingMaskIntoConstraints = false
        sideView.addSubview(sideController.view)
        
        NSLayoutConstraint.activate([sideController.view.leadingAnchor.constraint(equalTo: sideView.leadingAnchor),
                                     sideController.view.trailingAnchor.constraint(equalTo: sideView.trailingAnchor),
                                     sideController.view.topAnchor.constraint(equalTo: sideView.topAnchor),
                                     sideController.view.bottomAnchor.constraint(equalTo: sideView.bottomAnchor)])
        sideView.layoutIfNeeded()
    }
    
    override func moveStuff() {
        super.moveStuff()
    }
}
