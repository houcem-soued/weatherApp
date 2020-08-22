//
//  ViewController.swift
//  CityWeather
//
//  Created by Houcem Soued on 12/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var viewModel: CitiesListViewModel?
    var barButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel?.showLoader = { [weak self] shouldShow in
            shouldShow ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
        viewModel?.refreshView = {
            self.tableView.reloadData()
        }
        viewModel?.getCitiesWeather()
    }
    
    private func setupView() {
        self.title = "cities_title".localized
        
        barButton = UIBarButtonItem(image: UIImage(named: "plusIcon"), style: .plain, target: self, action: #selector(didPressAddCity))
        barButton?.tintColor = UIColor(named: "orange")
        navigationItem.rightBarButtonItem = barButton
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell")
        tableView.register(UINib(nibName: "ErrorDisplayCell", bundle: nil), forCellReuseIdentifier: "ErrorDisplayCell")
    }
    
    @objc
    private func didPressAddCity() {
        viewModel?.showAddCity()
    }
}

extension CitiesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfCells() ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel?.cellFor(indexPath: indexPath)
        switch cellType {
        case .errorCell(let error):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ErrorDisplayCell", for: indexPath) as! ErrorDisplayCell
            cell.setupCell(error: error)
            return cell
        case .cityCell(let city):
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
            cell.setupCell(city: city)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let city = viewModel?.getCity(at: indexPath.row) {
            viewModel?.showCityDetails(city: city)
        }
    }
}

