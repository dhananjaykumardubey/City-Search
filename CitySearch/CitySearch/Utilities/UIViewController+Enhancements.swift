//
//  UIViewController+Enhancements.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import UIKit

extension UIViewController {
    
    ///  Height of status bar + navigation bar (if navigation bar exist)
    var topBarHeight: CGFloat {
        var top = self.navigationController?.navigationBar.frame.height ?? 0.0
        if #available(iOS 13.0, *) {
            top += UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            top += UIApplication.shared.statusBarFrame.height
        }
        return top
    }
    
    /// stroyboard idenfitier for to load the XIB from a stroyboard
    static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
    
    /// Used to present a view controller on top of another view controller as a PopOver
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
