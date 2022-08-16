//
//  WeatherAPIManager.swift
//  SeSAC2Week6
//
//  Created by Brother Model on 2022/08/16.
//

import UIKit

import Alamofire
import SwiftyJSON

class WeatherAPIManager {
    static let shared = WeatherAPIManager()
    private init() { }
    
    typealias completionHandler = (String, String, String, Double, String, String) -> Void
    func getWeatherData(completionHandler: @escaping completionHandler) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=37.566713&lon=126.978428&appid=\(WeatherAPIKey.open)"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let weatherMain = json["weather"][0]["main"].stringValue
                let description = json["weather"][0]["description"].stringValue
                let icon = json["weather"][0]["icon"].stringValue
                let temp = json["main"]["temp"].doubleValue - 273.15
                let country = json["sys"]["country"].stringValue
                let name = json["name"].stringValue
                
                completionHandler(weatherMain, description, icon, temp, country, name)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
