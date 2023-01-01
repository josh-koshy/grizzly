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
    @Environment(\.colorScheme) var colorScheme // detect if dark mode or not (https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-dark-mode)
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button( action: { printhello(); counter += 1; rigidHaptic(); if ((counter % 20) == 0) {
                        isShowingDatViewWhichIsViewNumber2 = true
                    } } ) { Text("Rylie Meier is a very interesting and talented individual").font(.subheadline).fontWeight(.bold).foregroundColor(colorScheme == .dark ? Color.white : Color.black).padding(5.0)  }
                }
                Section { Text("This number will update: " + String(counter)) }
                Section {
                    NavigationLink(destination: AboutView(), isActive: $isShowingDatViewWhichIsViewNumber2) { Text("About") } }
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




