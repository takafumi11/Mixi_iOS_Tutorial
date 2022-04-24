//
//  ContentView.swift
//  Mixi_iOS_Tutorial
//
//  Created by 野入隆史 on 2022/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, world!")
                .padding()
            Text("Good evening, world!")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
