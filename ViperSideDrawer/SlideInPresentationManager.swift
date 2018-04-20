//
//  SlideInPresentationManager.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 29/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

protocol SideDrawerPresentationControllerInput: class {
    var isUserInteractionEnabled: Bool {get set}
}

public enum SideDrawerPresentationDirection {
    case left
    case right
}

public enum SideDrawerPresentationType {
    case slideIn
    case reveal
}

public class SlideInPresentationManager: NSObject {

    let direction: SideDrawerPresentationDirection
    let type: SideDrawerPresentationType
    let widthRatio: CGFloat
    let swipePercentThreshold: CGFloat
    
    fileprivate weak var presentationControllerInput: SideDrawerPresentationControllerInput?
    let percentInteractiveTransition: PercentInteractiveTransition

    public init(widthRatio: CGFloat, swipePercentThreshold: CGFloat = 0.3, type: SideDrawerPresentationType, direction: SideDrawerPresentationDirection, interactiveTransition: PercentInteractiveTransition? = nil) {
        self.widthRatio = widthRatio
        self.type = type
        self.direction = direction
        self.swipePercentThreshold = swipePercentThreshold
        self.percentInteractiveTransition = interactiveTransition ?? PercentInteractiveTransition()
    }

    public func setUserInteraction(enabled: Bool) {
        presentationControllerInput?.isUserInteractionEnabled = enabled
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate, SlideInPresentationControllerDelegate, RevealPresentationControllerDelegate {

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        switch type {
        case .slideIn:
            let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction, percentInteractiveTransition: percentInteractiveTransition)
            presentationController.presentationDelegate = self
            presentationControllerInput = presentationController
            return presentationController
        case .reveal:
            let presentationController = RevealPresentationController(presentedViewController: presented, presenting: presenting, direction: direction, percentInteractiveTransition: percentInteractiveTransition)
            presentationController.presentationDelegate = self
            presentationControllerInput = presentationController
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

    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentInteractiveTransition
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentInteractiveTransition.interactionInProgress ? percentInteractiveTransition : nil
    }
}
