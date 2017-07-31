//
//  RevealPresentationController.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 06/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

protocol RevealPresentationControllerDelegate: class {
    var widthRatio: CGFloat { get }
}

class RevealPresentationController: UIPresentationController {

    weak var presentationDelegate: RevealPresentationControllerDelegate?

    private var direction: SideDrawerPresentationDirection

    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: SideDrawerPresentationDirection) {
        self.direction = direction

        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

        setUpDimmingView()
    }

    fileprivate var dimmingView: UIView!

    override func presentationTransitionWillBegin() {
        self.containerView?.insertSubview(self.dimmingView, at: 0)

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: ["dimmingView": dimmingView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: ["dimmingView": dimmingView]))

        guard let coordinator = presentedViewController.transitionCoordinator else {
            self.dimmingView.alpha = 1.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }

    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            self.dimmingView.alpha = 0.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }

    override func containerViewWillLayoutSubviews() {
        self.presentedView?.frame = frameOfPresentedViewInContainerView
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        let size = CGSize(width: parentSize.width * (self.presentationDelegate?.widthRatio ?? 1.0), height: parentSize.height)
        return size
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        var frame = CGRect.zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        switch direction {
        case .right:
            frame.origin.x = containerView!.frame.width * (self.presentationDelegate?.widthRatio ?? 1.0)
        default:
            break
        }
        return frame
    }

}

// MARK: - Private
private extension RevealPresentationController {
    func setUpDimmingView() {
        self.dimmingView = UIView()
        self.dimmingView.translatesAutoresizingMaskIntoConstraints = false
        self.dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        self.dimmingView.alpha = 0.0

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        self.dimmingView.addGestureRecognizer(recognizer)
    }

    @objc dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
