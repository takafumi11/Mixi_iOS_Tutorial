//
//  RepoDetail.swift
//  Mixi_iOS_Tutorial
//
//  Created by 野入隆史 on 2022/04/24.
//

import SwiftUI

struct RepoDetailView: View {
    var repo: Repo
    
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image("GitHubMark")
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text(repo.owner.name)
                            .font(.caption)
                        
                    }
                    
                    Text(repo.name)
                        .fontWeight(.bold)
                        .font(.body
                        )
                    
                    Text(repo.description)
                        .padding(4)
                    
                    HStack {
                        Image(systemName: "star")
                        Text("\(repo.stargazersCount) Stars")
                            
                    }
                    .padding(8)
                    
                    Spacer()
                }
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
                        
    }
}

struct RepoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepoDetailView(repo: .mock1)
    }
}

