//
//  ViewController.swift
//  weather-forecast
//
//  Created by Xiong Hang Chen on 17/4/18.
//  Copyright © 2018 Xiong Hang Chen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var cityCountry: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var currentForecast: CurrentForecast!
    var weatherForecast: WeatherForecast!
    var weatherArray = [WeatherForecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegateCalls()
        getWeatherForecastData {
            //print("FORECAST DATA DOWNLOAD COMPLETE")
            self.viewUpdate()
        }
    }
    
    func delegateCalls() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func viewUpdate() {
        cityCountry.text = currentForecast.cityCountry
        weatherType.text = currentForecast.weatherType
        currentTemp.text = String(currentForecast.currentTemp) + " F"
        currentDate.text = currentForecast.currentDate
    
        if ((weatherType.text?.lowercased().range(of: "thunder")) != nil) {
            weatherImg.image = #imageLiteral(resourceName: "storm")
        }
        if ((weatherType.text?.lowercased().range(of: "rain")) != nil) {
            weatherImg.image = #imageLiteral(resourceName: "rain")
        }
        if ((weatherType.text?.lowercased().range(of: "cloud")) != nil) {
            weatherImg.image = #imageLiteral(resourceName: "cloud")
        }
        if ((weatherType.text?.lowercased().range(of: "sun")) != nil) {
            weatherImg.image = #imageLiteral(resourceName: "sun")
        }
        if ((weatherType.text?.lowercased().range(of: "wind")) != nil) {
            weatherImg.image = #imageLiteral(resourceName: "wind")
        }
    }
    
    //get json using Alamofire
    func getWeatherForecastData(completed: @escaping downloadedData) {
        Alamofire.request(API_JSON_STRING_URL).responseJSON {
            (response) in
            let result = response.result
            
            //JSON() is from SwiftyJSON
            let json = JSON(result.value as Any)
            
            //current forecast data
            let currCityCountry = json["query"]["results"]["channel"]["location"]["city"].stringValue + ", " + json["query"]["results"]["channel"]["location"]["country"].stringValue
            let currWeatherType = json["query"]["results"]["channel"]["item"]["condition"]["text"].stringValue
            let currTemp = json["query"]["results"]["channel"]["item"]["condition"]["temp"].intValue
            let currDate = json["query"]["results"]["channel"]["item"]["condition"]["date"].stringValue
            self.currentForecast = CurrentForecast(city: currCityCountry, type: currWeatherType, temp: currTemp, date: currDate)
            
            //build dictionary
            let forecastList = json["query"]["results"]["channel"]["item"]["forecast"]
            for i in 0..<forecastList.count {
                let forecast = WeatherForecast(forecastDict: forecastList[i])
                self.weatherArray.append(forecast)
                //print("\(forecastList[i])")
            }
            self.tableView.reloadData()
            completed()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell") as! ForecastTableViewCell
        cell.configCell(weatherData: weatherArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count
    }
}

