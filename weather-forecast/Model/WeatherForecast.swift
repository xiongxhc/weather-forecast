//
//  WeatherForecast.swift
//  weather-forecast
//
//  Created by Xiong Hang Chen on 17/4/18.
//  Copyright © 2018 Xiong Hang Chen. All rights reserved.
//

import Foundation
import SwiftyJSON

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
    
    init(forecastDict: JSON) {
        self._forecastDate_ = forecastDict["date"].stringValue + ", " + forecastDict["day"].stringValue
        self._forecastType_ = forecastDict["text"].stringValue
        self._forecastLow_ = forecastDict["low"].stringValue
        self._forecastHigh_ = forecastDict["high"].stringValue
    }
    
}
