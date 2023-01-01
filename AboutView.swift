//
//  AboutView.swift
//  CrospV4
//
//  Created by Joshua Koshy on 1/1/23.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.openURL) private var openURL
    var urlString: String = "https://github.com/josh-koshy"
    var body: some View {
        NavigationView {
            VStack(spacing: 30.0) {
                Button(action: {
                    guard let url = URL(string: urlString) else { return }
                    openURL(url)
                }) { Text("My First Project of the New Year").fontWeight(Font.Weight.bold) }
                Text("Copyright 2023, Joshua Koshy.")
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View { AboutView() }
}
