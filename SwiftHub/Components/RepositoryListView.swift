//
//  RepositoryListView.swift
//  SwiftHub
//
//  Created by Ricardo Carra Marsilio on 27/10/20.
//

import FetchImage
import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var image: FetchImage
    let repository: Repository
    private let minimumScaleFactor: CGFloat = 0.7
    
    init(_ repository: Repository) {
        self.repository = repository
        image = FetchImage(url: URL(string: repository.owner.pictureURL)!)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(repository.name)
                    .bold()
                    .font(.title2)
                    .minimumScaleFactor(minimumScaleFactor)
                
                Text(repository.description ?? "sem descrição")
                    .font(.subheadline)
                    .foregroundColor(Color("discreteGray"))
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(minimumScaleFactor)
                
                Spacer()
//                    .frame(height: 8)
                
                HStack {
                    Text(repository.starCount.description)
                    Text("⭐️")
                        .baselineOffset(3)
                }
            }
            
            Spacer()
            
            OwnerInfoView(repository.owner)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
        .padding(10)
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView(.mocked)
            .previewLayout(.fixed(width: 375, height: 100))
    }
}

struct OwnerInfoView: View {
    @ObservedObject var image: FetchImage
    @State private var userDetailPresented: Bool = false
    var owner: Repository.Owner
    
    init(_ owner: Repository.Owner) {
        self.owner = owner
        self.image = FetchImage(url: URL(string: self.owner.pictureURL)!)
    }
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 4) {
            image
                .view?
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
            Text(owner.name)
                .font(.subheadline)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .frame(maxWidth: 70)
        }
        .onAppear {
            self.image.priority = .normal
            self.image.fetch()
        }
        .onDisappear {
            self.image.priority = .low
        }
        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/) {
            self.userDetailPresented = true
        }
        .sheet(isPresented: $userDetailPresented) {
            UserDetailView(url: owner.profileURL, isPresented: $userDetailPresented)
        }
    }
}
