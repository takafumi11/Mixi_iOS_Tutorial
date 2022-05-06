//
//  RepoRepository.swift
//  Mixi_iOS_Tutorial
//
//  Created by Noiri, Takafumi | Taka | ELPD on 2022/05/06.
//

import Foundation

struct RepoRepository {
    func fetchRepos() async throws -> [Repo] {
        try await RepoAPIClient().getRpos()
    }
}
