//
//  ViewController.swift
//  CitySearch
//
//  Created by Dhananjay Dubey on 29/7/21.
//

import UIKit

final class CityListViewController: UIViewController {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
        }
    }
    @IBOutlet private weak var searchTextField: UITextField! {
        didSet {
            self.searchTextField.textColor = UIColor.orange
            self.searchTextField.placeholder = "Search"
            self.searchTextField.borderStyle = .roundedRect
            self.searchTextField.addDoneButton()
            self.searchTextField.delegate = self
        }
    }
    
    private var viewModel: CityListViewModel?
    private var dataSource: CityListDataSource?
    
    private var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupActivityIndicator()
        self.tableView.register(nib: .CityCell)
        self.viewModel = CityListViewModel(with: CityService(fileName: "cities", bundle: .main))
        self.bindViewModel()
    }
    
    private func setupActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .gray
        }
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = false
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        self.activityIndicator = activityIndicator
    }
    
    private func bindViewModel() {
        
        self.viewModel?.startLoading = { [weak self] in
            guard let _self = self else { return }
            _self.tableView.isHidden = true
            _self.activityIndicator?.startAnimating()
        }

        self.viewModel?.endLoading = { [weak self] in
            guard let _self = self else { return }
            _self.tableView.isHidden = false
            _self.activityIndicator?.stopAnimating()
        }

        self.viewModel?.showError = { [weak self] message in
            guard let _self = self else { return }
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(action)
            _self.present(alertController, animated: true)
        }

        self.viewModel?.cities = { [weak self] cities in
            guard let _self = self else { return }
            _self.dataSource = CityListDataSource(with: cities)
            _self.tableView.dataSource = _self.dataSource
            _self.tableView.reloadData()
        }
        
        self.viewModel?.citySelectionObserver = { [weak self] in
            guard let _self = self,
                  _self.tableView.hasRow(at: $0.1) else { return }
            _self.tableView.scrollToRow(at: $0.1, at: .top, animated: true)
            let heightOfCell = _self.tableView.cellForRow(at: $0.1)?.frame.size.height ?? 50.0
            
            let screenSize = UIScreen.main.bounds.size
            let mapsVc = MapsViewController.instantiate(with: $0.0, locationName: $0.2)
            _self.present(mapsVc,
                          onSourceView: _self.view,
                          onSourceRect: CGRect(x: 0, y: _self.topBarHeight + 50 + heightOfCell, width: screenSize.width, height: 0),
                          forContentSize: CGSize(width: screenSize.width, height: screenSize.height),
                          animated: true,
                          completion: nil)
        }
        
        self.viewModel?.bindViewModel()
    }
}

extension CityListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = self.dataSource?.city(in: tableView, at: indexPath) else { return }
        self.viewModel?.didSelect(city, at: indexPath)
    }
}

extension CityListViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.viewModel?.search(for:
            textField.text.replaceCharacter(
                in: range, replacementString: string))
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let text = textField.text {
            self.viewModel?.search(for: text)
        }
    }
}
