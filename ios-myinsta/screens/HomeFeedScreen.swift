//
//  HomeFeedScreen.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 27/09/21.
//

import SwiftUI

struct HomeFeedScreen: View {
    @EnvironmentObject var session: SessionStore
    @Binding var tabSelection: Int
    @ObservedObject var viewModel = FeedViewModel()
    var body: some View {
        NavigationView{
            ZStack{
                if !viewModel.items.isEmpty {
                    List{
                        ForEach(viewModel.items, id:\.self){ item in
                            if let uid = session.session?.uid! {
                                FeedPostCell(uid: uid, viewModel: viewModel, post: item,tabSelection: $tabSelection)
                                    .listRowInsets(EdgeInsets())
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }else if viewModel.isLoading == false && viewModel.items.isEmpty{
                    VStack{
                        Image(systemName: "person.badge.plus")
                            .renderingMode(.original)
                            .font(.system(size: 50))
                            .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                        Text("If you want to watch photos another users, you have to following them.")
                            .fontWeight(.thin)
                            .font(.title3)
                    }
                    .padding(.all, 20)
                }
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(trailing:
                                    Button(action:{
                                        self.tabSelection = 2
                                    }){
                                        Image(systemName: "camera")
                                            .font(.title3)
                                    }
            )
            .navigationBarTitle("app_name", displayMode: .inline)
        }
        .onAppear{
            if let uid = session.session?.uid! {
                viewModel.apiFeedList(uid:uid)
            }
        }
    }
}

struct HomeFeedScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedScreen(tabSelection: .constant(0))
    }
}
