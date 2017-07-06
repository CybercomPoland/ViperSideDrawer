//
//  SlideInPresentationAnimator.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 29/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

final class SlideInPresentationAnimator: NSObject {

    // MARK: - Properties
    let direction: PresentationDirection
    let isPresentation: Bool

    init(direction: PresentationDirection, isPresentation: Bool) {
        self.direction = direction
        self.isPresentation = isPresentation
        super.init()
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension SlideInPresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let childVCKey = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from

        let childVC = transitionContext.viewController(forKey: childVCKey)!

        if isPresentation {
            transitionContext.containerView.addSubview(childVC.view)
        }

        let childPresentedFrame = transitionContext.finalFrame(for: childVC)
        var childDismissedFrame = childPresentedFrame


        switch direction {
        case .left:
            childDismissedFrame.origin.x = -childPresentedFrame.width
        case .right:
            childDismissedFrame.origin.x = transitionContext.containerView.frame.size.width
        }

        let childInitialFrame = isPresentation ? childDismissedFrame : childPresentedFrame
        let childFinalFrame = isPresentation ? childPresentedFrame : childDismissedFrame

        let animationDuration = transitionDuration(using: transitionContext)
        childVC.view.frame = childInitialFrame

        UIView.animate(withDuration: animationDuration, animations: {
            childVC.view.frame = childFinalFrame
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }


}
