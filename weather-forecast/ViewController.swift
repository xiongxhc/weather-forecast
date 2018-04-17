//
//  ViewController.swift
//  weather-forecast
//
//  Created by Xiong Hang Chen on 17/4/18.
//  Copyright © 2018 Xiong Hang Chen. All rights reserved.
//

import UIKit

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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        delegateCalls()
        currentForecast = CurrentForecast()
        currentForecast.getCurrentWeatherData {
            //print("API DATA DOWNLOAD COMPLETE")
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
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell") as! ForecastTableViewCell
        cell.configCell(date: "12 Apr 2018, Wed", type: "Cloudy", lowTemp: 82, highTemp: 88)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

