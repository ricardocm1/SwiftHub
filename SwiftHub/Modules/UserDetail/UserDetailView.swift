//
//  UserDetailView.swift
//  SwiftHub
//
//  Created by Ricardo Carra Marsilio on 29/10/20.
//

import SwiftUI
import FetchImage

struct UserDetailView: View {
    @ObservedObject var viewModel: UserDetailViewModel
    @Binding var isPresented: Bool
    
    init(url: String, isPresented: Binding<Bool>) {
        viewModel = UserDetailViewModel(urlString: url)
        self._isPresented = isPresented
    }
    
    var body: some View {
        
        NavigationView {
            Group {
                if let user = viewModel.user {
                    UserDetailBodyView(user: user)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .mainPurple))
                }
            }
            .navigationBarItems(trailing: Button(action: {
                isPresented = false
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
            }))
            .navigationBarTitle(viewModel.user?.type.rawValue ?? "", displayMode: .inline)
            .onAppear {
                viewModel.fetchUser()
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let view = UserDetailView(url: Repository.mocked.owner.profileURL, isPresented: .constant(true))
        
        view.viewModel.user = .mocked
        
        return view
    }
}

struct UserDetailBodyView: View {
    var user: User
    @ObservedObject var image: FetchImage
    
    init(user: User) {
        self.user = user
        image = FetchImage(url: URL(string: user.pictureURL)!)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            image
                .view?
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
            
            Text(user.name)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.heavy)
            
            Text(user.bio)
                .font(.body)
                .foregroundColor(.description)
                .multilineTextAlignment(.center)
            
            TextLinkView(title: user.email) {
                
            }
            
            TextLinkView(title: user.blog) {
                
            }
            
            Spacer()
            
            HStack {
                NumericInfoView(value: user.repos, title: "repos")
                Spacer()
                NumericInfoView(value: user.followers, title: "followers")
                Spacer()
                NumericInfoView(value: user.following, title: "following")
            }
            
        }
        .padding(40)
    }
}
