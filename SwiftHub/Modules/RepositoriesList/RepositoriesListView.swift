//
//  RepositoriesListView.swift
//  SwiftHub
//
//  Created by Ricardo Carra Marsilio on 27/10/20.
//

import SwiftUI

struct RepositoriesListView: View {
    @ObservedObject var viewModel = RepositoriesListViewModel()
    
    init() {
        configNavigationBarAppearance()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repositories) { repo in
                    NavigationLink(destination: RepositoryDetailView(repository: repo)) {
                        RepositoryListView(repo)
                        
//                        NavigationLink(destination: UserDetailView(url: repo.owner.profileURL, isPresented: .constant(true))) {
//                            RepositoryListView(repo)
//                        }
                    }
                }
            }
            .navigationBarTitle("Repositories", displayMode: .inline)
        }
        .accentColor(.white)
    }
}

struct RepositoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        let view = RepositoriesListView()
        view.viewModel.repositories = [ .mocked, .mocked, .mocked ]
        
        return view
    }
}
