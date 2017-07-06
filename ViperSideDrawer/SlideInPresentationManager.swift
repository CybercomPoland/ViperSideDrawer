//
//  SlideInPresentationManager.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 29/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

enum PresentationDirection {
    case left
    case right
}

enum PresentationType {
    case slideIn
    case reveal
}

public class SlideInPresentationManager: NSObject {

    let direction: PresentationDirection
    let type: PresentationType
    let widthRatio: CGFloat

//    var swipeInteractionController: SwipeInteractionController?

    init(widthRatio: CGFloat, type: PresentationType, direction: PresentationDirection) {
        self.widthRatio = widthRatio
        self.type = type
        self.direction = direction
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate, SlideInPresentationControllerDelegate, RevealPresentationControllerDelegate {

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        switch type {
        case .slideIn:
            let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: self.direction)
            presentationController.presentationDelegate = self
            return presentationController
        case .reveal:
            let presentationController = RevealPresentationController(presentedViewController: presented, presenting: presenting, direction: self.direction)
            presentationController.presentationDelegate = self
            return presentationController
        }
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch type {
        case .slideIn:
            return SlideInPresentationAnimator(direction: direction, isPresentation: true)
        case .reveal:
            return RevealPresentationAnimator(direction: direction, isPresentation: true)
        }
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch type {
        case .slideIn:
            return SlideInPresentationAnimator(direction: direction, isPresentation: false)
        case .reveal:
            return RevealPresentationAnimator(direction: direction, isPresentation: false)
        }
    }

//    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return swipeInteractionController
//    }
//
//    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return (swipeInteractionController?.interactionInProgress ?? false) ? swipeInteractionController : nil
//    }
}
