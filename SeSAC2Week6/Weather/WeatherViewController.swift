//
//  WeatherViewController.swift
//  SeSAC2Week6
//
//  Created by Brother Model on 2022/08/16.
//

import UIKit

import Kingfisher

class WeatherViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = nowDate()

        WeatherAPIManager.shared.getWeatherData { weather, description, icon, temp, country, name in
            self.locationLabel.text = "\(country), \(name)"
            self.tempLabel.text = String(temp)
            self.weatherLabel.text = weather
            self.descriptionLabel.text = description
            let imageURL = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") 
            self.weatherImageView.kf.setImage(with: imageURL)
        }
        
        
    }
    
    func nowDate() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 HH시 mm분"
        return dateFormatter.string(from: now)
    }

}
