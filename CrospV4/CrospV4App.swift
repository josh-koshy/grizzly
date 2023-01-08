//
//  CrospV4App.swift
//  CrospV4
//
//  Created by Joshua Koshy on 12/31/22.
//

import SwiftUI
import SwiftOTP
import NWWebSocket

@main


struct CrospV4App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


func generateTOTP(secret: String) -> String {
    guard let data = base32DecodeToData(secret) else { return "" }
    
    if let totp = TOTP(secret: data) {
        let otpString = totp.generate(secondsPast1970: Int(Date().timeIntervalSince1970))
        if let unwrappedOTP = otpString {
            return unwrappedOTP
        }
    }
    return ""
}





// Use the WebSocket…
