//
//  AddCityViewController.swift
//  CityWeather
//
//  Created by Houcem Soued on 12/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var viewModel: AddCityViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViewModel()
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.viewWillDisappear()
    }
    
    @objc func searchAction(){
        viewModel?.getWeather(by: searchTextField.text)
    }
    
    private func setupViewModel() {
        viewModel?.showLoader = { [weak self] shouldShow in
            shouldShow ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
        viewModel?.showError = { [weak self] error in
            self?.errorLabel.text = error.localizedDescription.localized
        }
    }
    
    private func setupViews() {
        searchTextField.layer.cornerRadius = 10
        searchTextField.delegate = self
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        searchTextField.leftView = leftPaddingView
        searchTextField.leftViewMode = .always
        let height = searchTextField.frame.height - 20
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: height + 10, height: height))
        let searchButton = UIButton(type: .custom)
        searchButton.frame = CGRect(x: 0, y: 0, width: height, height: height)
        searchButton.layer.cornerRadius = 6
        searchButton.backgroundColor = UIColor(named: "orange") ?? .blue
        searchButton.setImage(UIImage(named: "search") ?? UIImage(), for: UIControl.State())
        searchButton.tintColor = .white
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        searchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        rightPaddingView.addSubview(searchButton)
        
        searchTextField.rightView = rightPaddingView
        searchTextField.rightViewMode = .always
        searchTextField.becomeFirstResponder()
    }
}

extension AddCityViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        errorLabel.text = nil
        return true
    }
}
