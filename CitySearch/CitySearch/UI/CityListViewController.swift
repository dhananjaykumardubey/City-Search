//
//  ViewController.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import UIKit

final class CityListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
        }
    }
    
    private var viewModel: CityListViewModel?
    private var dataSource: CityListDataSource?
    
    private var activityIndicator: UIActivityIndicatorView {
        let activityView = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityView.style = .large
        } else {
            activityView.style = .gray
        }
        activityView.backgroundColor = .black
        activityView.hidesWhenStopped = true
        return activityView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.activityIndicator.center = self.view.center
         self.view.addSubview(activityIndicator)
        
        self.tableView.register(nib: .CityCell)
        self.viewModel = CityListViewModel(with: CityService(fileName: "cities", bundle: .main))
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        
        self.viewModel?.startLoading = { [weak self] in
            guard let _self = self else { return }
            _self.activityIndicator.startAnimating()
        }

        self.viewModel?.endLoading = { [weak self] in
            guard let _self = self else { return }
            _self.activityIndicator.stopAnimating()
        }

        self.viewModel?.showError = { [weak self] message in
            guard let _self = self else { return }
            performOnMain {
                let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alertController.addAction(action)
                _self.present(alertController, animated: true)
            }
        }
        
        self.viewModel?.cities = { [weak self] cities in
            guard let _self = self else { return }
            _self.dataSource = CityListDataSource(with: cities)
            _self.tableView.dataSource = _self.dataSource
            _self.tableView.reloadData()
        }
        self.viewModel?.bindViewModel()
    }
}

extension CityListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
