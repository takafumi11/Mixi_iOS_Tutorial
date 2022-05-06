//
//  ContentView.swift
//  Mixi_iOS_Tutorial
//
//  Created by 野入隆史 on 2022/04/24.
//

import SwiftUI

enum Stateful<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
    
}

@MainActor
class ReposStore: ObservableObject {
    
    @Published private(set) var state: Stateful<[Repo]> = .idle

    func loadRepos() async {
        let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/vnd.github.v3+json"
        ]
        
        state = .loading
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let value = try decoder.decode([Repo].self, from: data)

            state = .loaded(value)
            
        } catch {
            state = .failed(error)
            print("error: \(error)")
        }
        
    }
}

struct RepoListView: View {
    @StateObject private var reposStore = ReposStore()
    let isProgressHidden: Bool = false
    
    var body: some View {
        NavigationView {
            Group {
                switch reposStore.state {
                case .idle, .loading:
                    ProgressView("loading...")
                case .loaded([]):
                    Text("No repositories")
                        .fontWeight(.bold)
                case let .loaded(repos):
                    List(repos) { repo in
                        NavigationLink(destination: RepoDetailView(repo: repo)) {
                            RepoRowView(repo: repo)
                        }
                    }
                case .failed:
                    VStack {
                        Group {
                            Image("GitHubMark")
                            Text("Failed to load repositories")
                                .padding(.top, 4)
                        }
                        .foregroundColor(.black)
                        .opacity(0.4)
                        Button(
                            action: {
                                Task {
                                    await reposStore.loadRepos()
                                }
                            },
                            label: {
                                Text("Retry")
                                    .fontWeight(.bold)
                            }
                        )
                        .padding(.top, 8)
                    }
                }
            }
            .navigationTitle("Repositories")
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
