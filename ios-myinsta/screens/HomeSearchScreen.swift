//
//  HomeSearchScreen.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 27/09/21.
//

import SwiftUI

struct HomeSearchScreen: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var viewModel = SearchViewModel()
    @State var keyword = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    TextField("Search for user", text: $keyword)
                        .padding(.horizontal, 15)
                        .frame(height: 45)
                        .font(.system(size: 16))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.5), lineWidth: 0.5))
                        .padding([.horizontal,.top], 20)
                    
                    List{
                        ForEach(viewModel.items, id:\.self){ item in
                            if let uid = (session.session?.uid) {
                                UserCell(uid: uid, user: item, viewModel: viewModel)
                                    .listRowInsets(EdgeInsets())
                                    .buttonStyle(PlainButtonStyle())
                            }
                            
                        }
                    }.listStyle(PlainListStyle())
                }
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarTitle("Search", displayMode: .inline)
        }
        .onAppear{
            if let uid = (session.session?.uid){
                viewModel.apiUserList(uid: uid, keyword: keyword)
            }
        }
    }
}

struct HomeSearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchScreen()
    }
}
