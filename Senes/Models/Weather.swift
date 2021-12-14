//
//  Weather.swift
//  Senes
//
//  Created by Konrad Cureau on 14/12/2021.
//

import Foundation

struct Weather: Codable {
    var forecast: Forecast = Forecast()
}

struct Forecast: Codable {
    var forecastday: [Forecastday] = [Forecastday]()
}

struct Forecastday: Codable {
    var date: String = "test date"
    var day: Day = Day()
}

struct Day: Codable {
    var avgtemp_c: Double = 0.0
    var condition: DayCondition = DayCondition()
}

struct DayCondition: Codable {
    var text: Condition = .unknow
    
    enum Condition: String, Codable {
        case cloudy = "Cloudy"
        case sunny = "Sunny"
        case partlyCloudy = "Partly cloudy"
        case overcast = "Overcast"
        case mist = "Mist"
        case unknow = "Unknow"
    }
    
    func returnSFWeather(condition: Condition) -> String? {
        switch condition {
        case .cloudy:
            return "cloud.fill"
        case .sunny:
            return "sun.max.fill"
        case .partlyCloudy:
            return "cloud.sun.fill"
        case .overcast:
            return "smoke.fill"
        case .mist:
            return "smoke.fill"
        case .unknow:
            return nil
        }
    }
}
