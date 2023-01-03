//
//  CrospV4App.swift
//  CrospV4
//
//  Created by Joshua Koshy on 12/31/22.
//

import SwiftUI

@main

struct CrospV4App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

func sleepMac() {
    // https://web.archive.org/web/20230103054739/https://stackoverflow.com/questions/24016142/how-to-make-http-request-in-swift
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 30
    configuration.timeoutIntervalForResource = 30
    let session = URLSession(configuration: configuration)
    
    let url = URL(string: "https://api.koshy.dev/sleep")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue(" ", forHTTPHeaderField: "device")
    
    let parameters = ["totp": ""]
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    } catch let error {
        print(error.localizedDescription)
    }
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        
        if error != nil || data == nil {
            print("Client error!")
            return
        }
        
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            print("Oops!! there is server error!")
            return
        }
        
        guard let mime = response.mimeType, mime == "application/json" else {
            print("response is not json")
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: [])
            print("The Response is : ",json)
        } catch {
            print("JSON error: \(error.localizedDescription)")
        }
        
    })
    
    task.resume()
}
