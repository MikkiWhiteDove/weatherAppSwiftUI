//
//  WeatherManager.swift
//  WeatherSwiftUI
//
//  Created by Mishana on 22.02.2022.
//

import Foundation
import CoreLocation

class WeatherManager{
    private var appId = "ad1b6159c8f07f8995bd6beeb6850a72"
    
    func getCurrentWeather(latitude: CLLocationDegrees , longitude: CLLocationDegrees) async throws -> ResponseBody {
        
        print("lat:\(latitude), lon: \(longitude)")
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(appId)&units=metric") else{
            fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let(data, responce) = try await URLSession.shared.data(for: urlRequest)
        
        guard (responce as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error status code no 200")}
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable{
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable{
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double {return feels_like}
    var tempMin: Double { return temp_min}
    var tempMax: Double {return temp_max}
}
