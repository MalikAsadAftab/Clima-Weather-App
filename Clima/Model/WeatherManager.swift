//
//  WeatherManager.swift
//  Clima
//
//  Created by Asad Aftab on 7/27/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=0b80dbfe35eb89dd3d19855335c23722&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        //print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString){
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3.  Give the session a task
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil{
                    print(error)
                    return
                }
                if let safeData = data  {
                    //let dataString = String(data : safeData, encoding: .utf8)
                    self.parseJSON(weatherData: safeData)
                    //print(dataString)
                    }
                }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            //print(decodedData.name, decodedData.main.temp, decodedData.weather[0].description, decodedData.weather[0].id)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(weatherID: id, cityName: name, temperature: temp)
            let conditionName = weather.conditionName
            
            print(weather.temperatureString)
            
        }catch{
            print(error)
        }
    }
    
    
}


