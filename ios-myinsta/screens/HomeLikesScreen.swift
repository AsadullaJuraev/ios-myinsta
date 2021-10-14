//
//  HomeLikesScreen.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 27/09/21.
//

import SwiftUI

struct HomeLikesScreen: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var viewModel = LikesViewModel()
    @State var uid = "uid"
    var body: some View {
        NavigationView{
            ZStack{
                if !viewModel.items.isEmpty{
                    List{
                        ForEach(viewModel.items, id:\.self){ item in
                            if let uid = session.session?.uid! {
                                LikePostCell(uid: uid, viewModel: viewModel, post: item)
                                    .listRowInsets(EdgeInsets())
                            }
                            
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                else if viewModel.isLoading == false && viewModel.items.isEmpty{
                    VStack{
                        Image(systemName: "heart.slash")
                            //.renderingMode(.original)
                            .font(.system(size: 50))
                            .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                        Text("You haven't any likes.")
                            .fontWeight(.thin)
                            .font(.title3)
                    }
                    .padding(.all, 20)
                }
            }
            .navigationBarTitle("Likes", displayMode: .inline)
        }
        .onAppear{
            if let uid = session.session?.uid! {
                self.viewModel.apiLikesList(uid: uid)
            }
        }
    }
}

struct HomeLikesScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeLikesScreen()
    }
}
