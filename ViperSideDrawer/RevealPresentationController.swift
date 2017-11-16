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
    var swipePercentThreshold: CGFloat { get }
}

class RevealPresentationController: UIPresentationController {

    weak var presentationDelegate: RevealPresentationControllerDelegate?

    fileprivate var direction: SideDrawerPresentationDirection
    fileprivate var percentInteractiveTransition: PercentInteractiveTransition?

    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: SideDrawerPresentationDirection, percentInteractiveTransition: PercentInteractiveTransition?) {
        self.direction = direction
        self.percentInteractiveTransition = percentInteractiveTransition

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
            frame.origin.x = containerView!.frame.width - (containerView!.frame.width * (self.presentationDelegate?.widthRatio ?? 1.0))
        default:
            break
        }
        return frame
    }

}

extension RevealPresentationController: SideDrawerPresentationControllerInput {
    var isUserInteractionEnabled: Bool {
        set {
            dimmingView.isUserInteractionEnabled = newValue
        }

        get {
            return dimmingView.isUserInteractionEnabled
        }
    }
}

// MARK: - Private
private extension RevealPresentationController {
    func setUpDimmingView() {
        self.dimmingView = UIView()
        self.dimmingView.translatesAutoresizingMaskIntoConstraints = false
        self.dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        self.dimmingView.alpha = 0.0

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        self.dimmingView.addGestureRecognizer(tapRecognizer)
        self.dimmingView.addGestureRecognizer(panRecognizer)
    }

    @objc dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }

    @objc dynamic func handlePan(recognizer: UIPanGestureRecognizer) {
        guard let viewBounds = presentedView?.bounds,
            let percentThreshold = presentationDelegate?.swipePercentThreshold else { return }
        let translation = recognizer.translation(in: self.dimmingView)
        let progress = TransitionHelper.calculateProgress(translation, viewBounds: viewBounds, direction: direction)
        TransitionHelper.translateGestureToInteractor(recognizer.state, progress: progress, percentThreshold: percentThreshold, percentInteractiveTransition: percentInteractiveTransition) {
            presentingViewController.dismiss(animated: true)
        }
    }
}
