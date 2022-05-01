//
//  ContentView.swift
//  Mixi_iOS_Tutorial
//
//  Created by 野入隆史 on 2022/04/24.
//

import SwiftUI

@MainActor
class ReposStore: ObservableObject {
    @Published private(set) var repos = [Repo]()

    func loadRepos() async {
        try! await Task.sleep(nanoseconds: 1_000_000_000)
        repos = [.mock1, .mock2, .mock3, .mock4, .mock5]
        
    }
}

struct RepoListView: View {
    @StateObject private var reposStore = ReposStore()
    let isProgressHidden: Bool = false
    
    var body: some View {
        NavigationView {
            if reposStore.repos.isEmpty {
                ProgressView("loading")
            } else {
                List(reposStore.repos) { repo in
                    NavigationLink(
                        destination: RepoDetailView(repo:repo)) {
                            RepoRowView(repo: repo)
                        }
                }
                .navigationTitle("Repositories")
            }
            
        }
        .task {
            await reposStore.loadRepos()
        }
    }
    
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}


