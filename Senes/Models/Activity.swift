//
//  Activity.swift
//  Senes
//
//  Created by Konrad Cureau on 12/12/2021.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    var id: String = UUID().uuidString
    var title: String = ""
    var userID: String = ""
    var location: String = ""
    var datePost: Date = Date()
    var dateStartActivity: Date = Date()
    var dateEndActivity: Date = Date(timeIntervalSinceNow: +3600)
    var pictureActivity: String?
    var numberParticipants: Int = 10
    var description: String = ""
    var centerOfInterest: CenterOfInterest = .arts
    
    static func ==(lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
    
    var isForecastAvailable: Bool {
        let now = Date()
        let dayIn3Days = now.addingTimeInterval(24.0 * 3600.0 * 3)
        let dateInterval = DateInterval(start: now, end: dayIn3Days)
        if dateInterval.contains(dateStartActivity) {
            return true
        } else {
            return false
        }
    }
    
    var dateActivityFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: dateStartActivity)
        
    }
    
    
    func determineWeather(weather: Weather) -> Forecastday {
        var forecastDay = Forecastday()
        if isForecastAvailable {
            if let result = weather.forecast.forecastday.filter({ $0.date == self.dateActivityFormatted }).first {
                forecastDay = result
            }
        }
        return forecastDay
    }
}
