//
//  ContentView.swift
//  CrospV4
//
//  Created by Joshua Koshy on 12/31/22.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var counter: Int = 0;
    @State var isShowingDatViewWhichIsViewNumber2: Bool = false
    @State private var name: String = "Rylie Meier"
    @Environment(\.colorScheme) var colorScheme // detect if dark mode or not (https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-dark-mode)
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button( action: {
                            counter += 1;
                            rigidHaptic();
                            if ((counter % 20) == 0) {
                                isShowingDatViewWhichIsViewNumber2 = true
                            }
                        
                    }) { // begin button label
                        ZStack(alignment: .leading) { // text and NavigationLink are within the ZStack
                            Text("\(name) is a very interesting and talented individual").font(.custom("EBGaramond-Medium", size: 20.0)).fontWeight(.bold).foregroundColor(colorScheme == .dark ? Color.white : Color.black).multilineTextAlignment(.leading) // Custom Font used here
                            
                            NavigationLink(destination: AboutView(), isActive: $isShowingDatViewWhichIsViewNumber2) { }.opacity(0.0)
                            .buttonStyle(PlainButtonStyle()) // Removes the 'chevron' or arrow to the right of the button
                        } // end ZSstack
                    }     // end Button Label
                }         // end Section
                
                
                
                Section { Text("This number will update: " + String(counter)) }

            }.navigationTitle("💻 Mac Control, by Josh Koshy").navigationBarTitleDisplayMode(.inline)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        AboutView()
        
    }
}




