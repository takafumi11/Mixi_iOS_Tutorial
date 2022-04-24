//
//  RepoRow.swift
//  Mixi_iOS_Tutorial
//
//  Created by 野入隆史 on 2022/04/24.
//

import SwiftUI

struct RepoRow: View {
    var repo: Repo
    
    var body: some View {
        HStack {
            Image("GitHubMark")
                .resizable()
                .frame(width: 44, height: 44)
            
            VStack(alignment: .leading) {
                Text(repo.owner.name)
                    .font(.caption)
                
                Text(repo.name)
                    .font(.body)
                    .fontWeight(.semibold)
                
            }
        }
    }
    
}

