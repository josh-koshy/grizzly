//
//  ContentView.swift
//  CrospV4
//
//  Created by Joshua Koshy on 12/31/22.
//

import SwiftUI
import WebSocket
import Network

class UserProgress: ObservableObject {
    @Published var score = "CVUWTTYW6LHTBKIVORA3TRLHIRF3UWPW"
    @Published var ip = "192.168.10.5"
}



struct ContentView: View {

    @StateObject var progress = UserProgress()
    @State public var zz = "Disconnected..."
    @State var counter: Int = 0;
    @State var isShowingDatViewWhichIsViewNumber2: Bool = false
    @State private var name: String = "Rylie Meier"
    @State var p: Float = 0.5
    @Environment(\.colorScheme) var colorScheme // detect if dark mode or not (https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-dark-mode)
    func sliderChanged() async {
        print("Slider value changed to \(p)")
        let message = "Hello, world!"
        do {
            let socket = try await WebSocket.system(url: URL(string: "ws://" + progress.ip + ":8080")!)
            try await socket.open()
            try await socket.send(.text("\(p)"))
        }
        catch {
            print(error)
        }
        
    }
    
    
    
    func sleepMac() {
        print("Function sleepMac called, response is: ")
        let session = URLSession.shared
        let url = URL(string: "https://api.koshy.dev/sleep?totp=" + generateTOTP(secret: progress.score))!
        
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
                        Task {
                            await sliderChanged()
                            
                        }
                            counter += 1;
                            rigidHaptic();
                            if ((counter % 5) == 0) {
                                isShowingDatViewWhichIsViewNumber2 = true
                            }
                        
                    }) { // begin button label
                        ZStack(alignment: .leading) { // text and NavigationLink are within the ZStack
                            Text("Connected to Josh's Macbook Pro through the Cloud").font(.custom("EBGaramond-Medium", size: 20.0)).fontWeight(.bold).foregroundColor(colorScheme == .dark ? Color.white : Color.black).multilineTextAlignment(.leading).lineLimit(nil).padding(.trailing, 20.0) // Custom Font used here
                            
                            NavigationLink(destination: AboutView(progress: progress), isActive: $isShowingDatViewWhichIsViewNumber2) { }.opacity(0.0)
                            .buttonStyle(PlainButtonStyle()) // Removes the 'chevron' or arrow to the right of the button
                        } // end ZSstack
                    }     // end Button Label
                }         // end Section
                
                
                
                
                Section {
                    
                    Button {
                        heavyHaptic(); sleepMac()
                    } label: {
                        Text("Press Here to Sleep Josh's MacBook Pro")
                            .foregroundColor(colorScheme == .dark ? Color.yellow : Color.red)
                            .fontWeight(.bold)
                    }
                    Text(zz).foregroundColor(colorScheme == .dark ? Color.white : Color.black) // replace with zz
                    
                    VStack{
                           Slider(value: Binding(get: {
                               self.p
                           }, set: { (newVal) in
                               Task {
                                   self.p = newVal
                                   await self.sliderChanged()
                               }
                           }))
                           .padding(.all)
                        }
                    
                    
 }
            }.navigationTitle("💻 Mac Control, by Josh Koshy").navigationBarTitleDisplayMode(.inline)
        }
    }
}



struct AboutView: View {
    @ObservedObject var progress: UserProgress
    
    @Environment(\.openURL) private var openURL
    var urlString: String = "https://github.com/josh-koshy"
    var body: some View {
        NavigationView {
            VStack(spacing: 30.0) {
                TextField("Enter Authorization Code", text: self.$progress.score).font(.system(size: 14.5))
                  .textFieldStyle(PlainTextFieldStyle())
                  // Text alignment.
                  .multilineTextAlignment(.center)
                  // Cursor color.
                  .accentColor(.pink)
                  // Text color.
                  .foregroundColor(.pink)
                  // Text/placeholder font.
                  .font(.body)
                  // TextField spacing.
                  .padding(.vertical, 12)
                  .padding(.horizontal, 50)
                  // TextField border.
                TextField("Enter Authorization Code", text: self.$progress.ip)
                    .textFieldStyle(PlainTextFieldStyle())
                    // Text alignment.
                    .multilineTextAlignment(.center)
                    // Cursor color.
                    .accentColor(.pink)
                    // Text color.
                    .foregroundColor(.pink)
                    // Text/placeholder font.
                    .font(.body)
                    // TextField spacing.
                    .padding(.vertical, 12)
                    .padding(.horizontal, 50)
                  
                
                Button(action: {
                    guard let url = URL(string: urlString) else { return }
                    openURL(url)
                }) { Text("My First Project of the New Year").fontWeight(Font.Weight.bold) }
                Text("Copyright 2023, Joshua Koshy.")
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(progress: ContentView().progress)
    }
}





