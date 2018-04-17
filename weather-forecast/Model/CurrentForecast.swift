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
    
    //Variables
    private var _cityCountry_: String!
    private var _weatherType_: String!
    private var _currentTemp_: Int!
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
    
    var currentTemp : Int {
        if _currentTemp_ == nil {
            _currentTemp_ = 0
        }
        return _currentTemp_
    }
    
    var currentDate : String {
        if _currentDate_ == nil {
            _currentDate_ = ""
        }
        return _currentDate_
    }
    
    //parsing json from given API url
    func getCurrentWeatherData(completed: @escaping downloadedData) {
        Alamofire.request(API_JSON_STRING_URL).responseJSON {
            (response) in
            let result = response.result
            print(result.value as Any)
            
            //JSON() is from SwiftyJSON
            let json = JSON(result.value as Any)
            
            //city and country
            self._cityCountry_ = json["query"]["results"]["channel"]["location"]["city"].stringValue + ", " + json["query"]["results"]["channel"]["location"]["country"].stringValue
            //weather types
            self._weatherType_ = json["query"]["results"]["channel"]["item"]["condition"]["text"].stringValue
            //current temperature
            self._currentTemp_ = json["query"]["results"]["channel"]["item"]["condition"]["temp"].intValue
            //current date
            self._currentDate_ = json["query"]["results"]["channel"]["item"]["condition"]["date"].stringValue
            
            print(self._cityCountry_)
            print(self._weatherType_)
            print(self._currentTemp_)
            print(self._currentDate_)
            
            completed()
        }
    }
    
}
