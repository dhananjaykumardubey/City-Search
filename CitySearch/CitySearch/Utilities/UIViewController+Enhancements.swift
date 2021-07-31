//
//  UIViewController+Enhancements.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import UIKit

extension UIViewController {
    
    static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
    
    func present(_ viewControllerToPopOver: UIViewController,
                 onSourceView: UIView,
                 onSourceRect: CGRect,
                 forContentSize: CGSize,
                 animated: Bool,
                 completion: (() -> Void)? = nil) {
        let nav = UINavigationController(rootViewController: viewControllerToPopOver)
        nav.modalPresentationStyle = .popover
        nav.isNavigationBarHidden = true
        if let popOver = nav.popoverPresentationController {
            viewControllerToPopOver.preferredContentSize = forContentSize
            popOver.sourceView = onSourceView
            popOver.delegate = self
            popOver.sourceRect = onSourceRect
        }
        present(nav, animated: animated, completion: completion)
    }
}

extension UIViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
