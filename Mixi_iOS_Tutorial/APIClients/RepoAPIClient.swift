//
//  RepoAPIClient.swift
//  Mixi_iOS_Tutorial
//
//  Created by Noiri, Takafumi | Taka | ELPD on 2022/05/06.
//

import Foundation

struct RepoAPIClient {
    func getRpos() async throws -> [Repo] {
        let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/vnd.github.v3+json"
        ]
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Repo].self, from: data)
    }
    
}

//    func loadRepos() async {
//        let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//        urlRequest.allHTTPHeaderFields = [
//            "Accept": "application/vnd.github.v3+json"
//        ]
//
//        state = .loading
//
//        do {
//            let (data, response) = try await URLSession.shared.data(for: urlRequest)
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                throw URLError(.badServerResponse)
//            }
//
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            let value = try decoder.decode([Repo].self, from: data)
//
//            state = .loaded(value)
//
//        } catch {
//            state = .failed(error)
//            print("error: \(error)")
//        }
//
//    }
