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

struct RepoListView: View {
    @StateObject private var viewModel: RepoListViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: RepoListViewModel())
    }
    
    let isProgressHidden: Bool = false
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
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
                                    await viewModel.onRetryButtonTapped()
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
        await viewModel.onAppear()
    }
    }
    
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
