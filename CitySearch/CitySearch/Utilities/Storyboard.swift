//
//  Storyboard.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import UIKit

enum Storyboard: String {
    case Main
    
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
