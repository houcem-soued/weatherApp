//
//  CityDetailsViewController.swift
//  CityWeather
//
//  Created by Houcem Soued on 13/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import UIKit

class CityDetailsViewController: UIViewController {
        
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureTitleLabel: UILabel!
    @IBOutlet weak var humidityTitleLabel: UILabel!
    
    var viewModel: CityDetailsViewModel?
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.city = viewModel?.city
        
        navigationItem.largeTitleDisplayMode = .never

        containerView.layer.cornerRadius = 10
        temperatureLabel.text = "\(city?.temperature ?? 0)°C"
        cityNameLabel.text = city?.name
        weatherIconImageView.image = UIImage(named: city?.iconName ?? "")
        weatherLabel.text = city?.weatherTitle
        
        if let pressure = city?.pressure {
            pressureTitleLabel.text = "pressure_title".localized
            pressureLabel.text = "\(pressure)) hPa"
        }
        if let humidity = city?.humidity {
            humidityTitleLabel.text = "humidity_title".localized
            humidityLabel.text = "\(humidity)%"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.viewWillDisappear()
    }
    
}
