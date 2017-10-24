//
//  TransitionHelper.swift
//  ViperSideDrawer
//
//  Created by Adrian Ziemecki on 19/10/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import UIKit

public class TransitionHelper {
    public static func calculateProgress(_ translationInView: CGPoint, viewBounds: CGRect, direction: SideDrawerPresentationDirection) -> CGFloat {
        let pointOnAxis: CGFloat = translationInView.x
        let axisLength: CGFloat = viewBounds.width
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis: Float
        let positiveMovementOnAxisPercentage: Float
        switch direction {
        case .left: // Negative
            positiveMovementOnAxis = fminf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercentage = fmaxf(positiveMovementOnAxis, -1.0)
            return CGFloat (-positiveMovementOnAxisPercentage)
        case .right: // Positive
            positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercentage = fminf(positiveMovementOnAxis, 1.0)
            return CGFloat (positiveMovementOnAxisPercentage)
        }
    }

    public static func translateGestureToInteractor(_ gestureState: UIGestureRecognizerState, progress: CGFloat, percentThreshold: CGFloat, interactor: SwipeInteractionController?, triggerSegue: () -> ()) {
        guard let interactor = interactor else { return }
        switch gestureState {
        case .began:
            interactor.interactionInProgress = true
            triggerSegue()
        case .changed:
            interactor.interactionShoudFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.interactionInProgress = false
            interactor.cancel()
        case .ended:
            interactor.interactionInProgress = false
            interactor.interactionShoudFinish ? interactor.finish() : interactor.cancel()
        default:
            break
        }
    }
}
