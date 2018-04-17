//
//  WeatherForecast.swift
//  weather-forecast
//
//  Created by Xiong Hang Chen on 17/4/18.
//  Copyright © 2018 Xiong Hang Chen. All rights reserved.
//

import Foundation

class WeatherForecast {
    private var _forecastDate_: String!
    private var _forecastType_: String!
    private var _forecastLow_: String!
    private var _forecastHigh_: String!
    
    var forecastDate : String {
        if _forecastDate_ == nil {
            _forecastDate_ = ""
        }
        return _forecastDate_
    }
    
    var forecastType : String {
        if _forecastType_ == nil {
            _forecastType_ = ""
        }
        return _forecastType_
    }
    
    var forecastLow : String {
        if _forecastLow_ == nil {
            _forecastLow_ = ""
        }
        return _forecastLow_
    }
    
    var forecastHigh : String {
        if _forecastHigh_ == nil {
            _forecastHigh_ = ""
        }
        return _forecastHigh_
    }
    
    init(forecastDict: Dictionary<String, AnyObject>) {
        
        //forecast date
        if let date = forecastDict["date"] as? String, let day = forecastDict["day"] as? String {
            self._forecastDate_ = date + ", " + day
        }
        
        // weather type
        if let type = forecastDict["text"] as? String {
            self._forecastType_ = type
        }
        
        //temperture range
        if let low = forecastDict["low"] as? String {
            self._forecastLow_ = low
        }
        if let high = forecastDict["high"] as? String {
            self._forecastHigh_ = high
        }
        
    }
    
}
