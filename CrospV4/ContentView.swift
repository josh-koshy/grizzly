//
//  ContentView.swift
//  CrospV4
//
//  Created by Joshua Koshy on 12/31/22.
//

import SwiftUI


struct ContentView: View {
    
    @State public var zz = ""
    @State var counter: Int = 0;
    @State var isShowingDatViewWhichIsViewNumber2: Bool = false
    @State private var name: String = "Rylie Meier"
    @Environment(\.colorScheme) var colorScheme // detect if dark mode or not (https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-dark-mode)
    
    func sleepMac() {
        print("Function sleepMac called, response is: ")
        let session = URLSession.shared
        let url = URL(string: "https://api.koshy.dev/sleep?totp=" + generateTOTP(secret: "CVUWTTYW6LHTBKIVORA3TRLHIRF3UWPW"))!
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                 print("Client error!")
                 return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            // https://www.hackingwithswift.com/example-code/system/how-to-parse-json-using-jsonserialization
            do {
                // make sure this JSON is in the format we expect
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    // try to read out a string array
                    if let status = json["Status"] as? String {
                        zz = status
                        print(status)
                    }
                    
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button( action: {
                            counter += 1;
                            rigidHaptic();
                            if ((counter % 5) == 0) {
                                isShowingDatViewWhichIsViewNumber2 = true
                            }
                        
                    }) { // begin button label
                        ZStack(alignment: .leading) { // text and NavigationLink are within the ZStack
                            Text("Connected to Josh's Macbook Pro through the Cloud").font(.custom("EBGaramond-Medium", size: 20.0)).fontWeight(.bold).foregroundColor(colorScheme == .dark ? Color.white : Color.black).multilineTextAlignment(.leading).lineLimit(nil).padding(.trailing, 20.0) // Custom Font used here
                            
                            NavigationLink(destination: AboutView(), isActive: $isShowingDatViewWhichIsViewNumber2) { }.opacity(0.0)
                            .buttonStyle(PlainButtonStyle()) // Removes the 'chevron' or arrow to the right of the button
                        } // end ZSstack
                    }     // end Button Label
                }         // end Section
                
                
                
                
                Section {
                    
                    Button {
                        sleepMac()
                    } label: {
                        Text("Press Here to Sleep Josh's MacBook Pro")
                            .foregroundColor(colorScheme == .dark ? Color.yellow : Color.red)
                            .fontWeight(.bold)
                    }
                    
                    Text(zz).foregroundColor(Color.white)
 }

            }.navigationTitle("💻 Mac Control, by Josh Koshy").navigationBarTitleDisplayMode(.inline)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




