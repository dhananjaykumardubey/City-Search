//
//  ViewController.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import UIKit

class ViewController: UIViewController {

    var client: LocalCitiesClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.client = CityService(fileName: "cities", bundle: .main)
        self.client?.fetchCities({ [weak self] response in
            guard let _self = self else {
                return
            }
            switch response {
            case let .success(cameraDetails):
               print("Data recieved")
            case let .failure(error):
                print("error recieved")
            }
        })
        
    }


}

