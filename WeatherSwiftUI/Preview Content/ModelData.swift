//
//  ModelData.swift
//  WeatherSwiftUI
//
//  Created by Mishana on 22.02.2022.
//

import Foundation

var previewWeather: ResponseBody = load("weatherData.json ")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("error \(filename) in main bundle.")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("ERROR load \(filename) from main bundle")
    }
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Errore parse \(filename), as \(T.self): \n\(error)")
    }
}
