//
//  CityTableViewCell.swift
//  CityWeather
//
//  Created by Houcem Soued on 12/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherTitleLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.cornerRadius = 6
    }

    func setupCell(city: City?) {
        cityNameLabel.text = city?.name?.capitalized
        weatherTitleLabel.text = city?.weatherDescription?.capitalized
        
        if let temperature = city?.temperature {
            temperatureLabel.text = "\(temperature)°C"
        }else {
            temperatureLabel.text = nil
        }
        
        iconImageView?.image = UIImage(named: city?.iconName ?? "")
    }
}
