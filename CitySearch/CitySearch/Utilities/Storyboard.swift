//
//  Storyboard.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import UIKit

/// Storyboard enum, to have list of all storyboards used in app.
/// Used to keep all the stpryboard names at one place, to avoid any duplicate naming in future
enum Storyboard: String {
    case Main
    
    /**
     Instantiate a view controller from a storyboard
        - parameters:
            - viewController: View controller which needs to be loaded from bundle from the storyboard
            - bundle: Bundle in which storyboard VC is present
            - returns: initialised view controller
    */
    func instantiate<VC: UIViewController>(_ viewController: VC.Type,
                                           inBundle bundle: Bundle = .main) -> VC {
        guard
            let vc = UIStoryboard(name: self.rawValue, bundle: bundle)
                .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
        else {
            fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)")
        }
        
        return vc
    }
}
