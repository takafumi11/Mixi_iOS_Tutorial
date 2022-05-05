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
        let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/vnd.github.v3+json"
        ]
        
        let (data, _) = try! await URLSession.shared.data(for: urlRequest)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let value = try! decoder.decode([Repo].self, from: data)
        
        repos = value
        
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
