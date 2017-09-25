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
    fileprivate weak var presentationControllerInput: SideDrawerPresentationControllerInput?

//    var swipeInteractionController: SwipeInteractionController?

     public init(widthRatio: CGFloat, type: SideDrawerPresentationType, direction: SideDrawerPresentationDirection) {
        self.widthRatio = widthRatio
        self.type = type
        self.direction = direction
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
            let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: self.direction)
            presentationController.presentationDelegate = self
            self.presentationControllerInput = presentationController
            return presentationController
        case .reveal:
            let presentationController = RevealPresentationController(presentedViewController: presented, presenting: presenting, direction: self.direction)
            presentationController.presentationDelegate = self
            self.presentationControllerInput = presentationController
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
