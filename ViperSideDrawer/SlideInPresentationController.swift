//
//  SlideInPresentationController.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 29/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

protocol SlideInPresentationControllerDelegate: class {
    var widthRatio: CGFloat { get }
    var swipePercentThreshold: CGFloat { get }
}

class SlideInPresentationController: UIPresentationController {

    weak var presentationDelegate: SlideInPresentationControllerDelegate?

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
        containerView?.insertSubview(dimmingView, at: 0)

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: ["dimmingView": dimmingView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: ["dimmingView": dimmingView]))

        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }

    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }

    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        let size = CGSize(width: parentSize.width * (presentationDelegate?.widthRatio ?? 1.0), height: parentSize.height)
        return size
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        var frame = CGRect.zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        switch direction {
        case .right:
            frame.origin.x = containerView!.frame.width - (containerView!.frame.width * (presentationDelegate?.widthRatio ?? 1.0))
        default:
            break
        }
        return frame
    }

}

extension SlideInPresentationController: SideDrawerPresentationControllerInput {
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
private extension SlideInPresentationController {
    func setUpDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0.0

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        dimmingView.addGestureRecognizer(tapRecognizer)
        dimmingView.addGestureRecognizer(panRecognizer)
    }

    @objc dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }

    @objc dynamic func handlePan(recognizer: UIPanGestureRecognizer) {
        guard let viewBounds = presentedView?.bounds,
            let percentThreshold = presentationDelegate?.swipePercentThreshold else { return }
        let translation = recognizer.translation(in: dimmingView)
        let progress = TransitionHelper.calculateProgress(translation, viewBounds: viewBounds, direction: direction)
        TransitionHelper.translateGestureToInteractor(recognizer.state, progress: progress, percentThreshold: percentThreshold, percentInteractiveTransition: percentInteractiveTransition) {
            presentingViewController.dismiss(animated: true)
        }
    }
}
