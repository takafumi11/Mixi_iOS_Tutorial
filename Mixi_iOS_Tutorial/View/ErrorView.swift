//
//  ErrorView.swift
//  Mixi_iOS_Tutorial
//
//  Created by 野入隆史 on 2022/05/05.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Repositories")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                
                Spacer()
            }
            
            VStack {
                Image("GitHubMark")
                Text("Faild to load repositories")
                
            }
            .foregroundColor(.gray)
            
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
