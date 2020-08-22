//
//  ErrorDisplayCell.swift
//  CityWeather
//
//  Created by Houcem Soued on 12/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import UIKit

class ErrorDisplayCell: UITableViewCell {

    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var error: NetworkError = .unknown
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(error: NetworkError?) {
        self.error = error ?? .unknown
        errorImageView.image = UIImage(named: self.error.previewImageName)
        titleLabel.text = self.error.localizedDescription.localized
    }
}
