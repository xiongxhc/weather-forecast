//
//  ForecastTableViewCell.swift
//  weather-forecast
//
//  Created by Xiong Hang Chen on 17/4/18.
//  Copyright © 2018 Xiong Hang Chen. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var forecastDate: UILabel!
    @IBOutlet weak var forecastType: UILabel!
    @IBOutlet weak var forecastTempRange: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(date: String, type: String, lowTemp: Int, highTemp: Int) {
        self.forecastDate.text = date
        self.forecastType.text = type
        self.forecastTempRange.text = String(lowTemp) + " F" + " ~ " + String(highTemp) + " F"
    }
}
