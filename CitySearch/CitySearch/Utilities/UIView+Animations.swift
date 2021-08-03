//
//  UIView+Animations.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 31/7/21.
//

import UIKit

extension UIView {
    
    /// Provide bouncing out animation with a delay
    func bounceOut(delay: Double = 1.0) {
        self.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        UIView.animate(withDuration: 0.5,
                       delay: delay,
                       usingSpringWithDamping: 1.5,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
                        self.transform = .identity
                       },
                       completion: nil)
    }
}
