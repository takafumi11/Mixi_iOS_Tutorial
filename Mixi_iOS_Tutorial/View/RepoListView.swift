//
//  ContentView.swift
//  Mixi_iOS_Tutorial
//
//  Created by 野入隆史 on 2022/04/24.
//

import SwiftUI

struct RepoListView: View {
    @State var mockRepos: [Repo] = []
    let isProgressHidden: Bool = false
    
    var body: some View {
        NavigationView {
            if mockRepos.isEmpty {
                ProgressView("loading")
            } else {
                List(mockRepos) { repo in
                    NavigationLink(
                        destination: RepoDetailView(repo:repo)) {
                            RepoRowView(repo: repo)
                        }
                }
                .navigationTitle("Repositories")
            }
            
        }.onAppear {
            loadRepos()
        }
    }
    
    private func loadRepos() {
        // 1秒後にモックデータを読み込む
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            mockRepos = [
                .mock1, .mock2, .mock3, .mock4, .mock5
            ]
        }
    }
    
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}


