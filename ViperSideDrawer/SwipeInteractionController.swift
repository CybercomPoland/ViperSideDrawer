//
//  SwipeInteractionController.swift
//  ViperSideDrawer
//
//  Created by Adrian Ziemecki on 25/10/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import Foundation

public class SwipeInteractionController {
    let swipeDirection: SideDrawerPresentationDirection
    let transitionThresholdPercent: CGFloat

    public let percentInteractiveTransition = PercentInteractiveTransition()

    public init(swipeDirection: SideDrawerPresentationDirection, transitionThreshold: CGFloat) {
        self.transitionThresholdPercent = transitionThreshold
        self.swipeDirection = swipeDirection
    }

    public func handleScreenEdgePanGesture (gesture: UIScreenEdgePanGestureRecognizer, view: UIView, triggerSegue: () -> ()) {
        let translation = gesture.translation(in: view)
        let progress = TransitionHelper.calculateProgress(translation, viewBounds: view.bounds, direction: swipeDirection)
        TransitionHelper.translateGestureToInteractor(gesture.state, progress: progress, percentThreshold: transitionThresholdPercent, percentInteractiveTransition: percentInteractiveTransition, triggerSegue: triggerSegue)
    }
}
