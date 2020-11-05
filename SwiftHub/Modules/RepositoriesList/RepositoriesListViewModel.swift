//
//  RepositoriesListViewModel.swift
//  SwiftHub
//
//  Created by Ricardo Carra Marsilio on 27/10/20.
//

import SwiftUI

class RepositoriesListViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    
    init() {
        fetchData()
    }
    
    private func fetchData() {
        let search = SearchAPIURLProvider(endpoint: .search(language: "swift"))
        
        Requester.request(search: search) { [weak self] (result: Result<SearchResult, APIError>) in
            switch result {
                case.success(let searchResult):
                    DispatchQueue.main.async {
                        self?.repositories = searchResult.items
                    }
                case.failure(let error):
                    print(error)
            }
        }
    }
}
