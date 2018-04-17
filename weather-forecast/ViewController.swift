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
    
    //Constants
    
    //Variables
    var currentForecast: CurrentForecast!
    var weatherForecast: WeatherForecast!
    var weatherArray = [WeatherForecast]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        delegateCalls()
        currentForecast = CurrentForecast()
        currentForecast.getCurrentWeatherData {
            //print("API DATA DOWNLOAD COMPLETE")
            self.viewUpdate()
        }
        getWeatherForecastData {
            print("API DATA DOWNLOAD COMPLETE")
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
    }
    
    //get json using Alamofire
    func getWeatherForecastData(completed: @escaping downloadedData) {
        Alamofire.request(API_JSON_STRING_URL).responseJSON {
            (response) in
            let result = response.result
            
            //build dictionary
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if (dict["query"] as? [Dictionary<String, AnyObject>]) != nil {
                    if (dict["results"] as? [Dictionary<String, AnyObject>]) != nil {
                        if (dict["channel"] as? [Dictionary<String, AnyObject>]) != nil {
                            if (dict["item"] as? [Dictionary<String, AnyObject>]) != nil {
                                if let list = dict["forecast"] as? [Dictionary<String, AnyObject>] {
                                    for each in list {
                                        let forecast = WeatherForecast(forecastDict: each)
                                        self.weatherArray.append(forecast)
                                    }
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
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

