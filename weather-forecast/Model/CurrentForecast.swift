//
//  CurrentForecast.swift
//  weather-forecast
//
//  Created by Xiong Hang Chen on 17/4/18.
//  Copyright © 2018 Xiong Hang Chen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrentForecast {
    
    private var _cityCountry_: String!
    private var _weatherType_: String!
    private var _currentTemp_: Double!
    private var _currentDate_: String!
    
    var cityCountry : String {
        if _cityCountry_ == nil {
            _cityCountry_ = ""
        }
        return _cityCountry_
    }
    
    var weatherType : String {
        if _weatherType_ == nil {
            _weatherType_ = ""
        }
        return _weatherType_
    }
    
    var currentTemp : Double {
        if _currentTemp_ == nil {
            _currentTemp_ = 0.0
        }
        return _currentTemp_
    }
    
    var currentDate : String {
        if _currentDate_ == nil {
            _currentDate_ = ""
        }
        return _currentDate_
    }
    
    func getCurrentWeatherData(completed: @escaping downloadedData) {
        
    }
    
}
