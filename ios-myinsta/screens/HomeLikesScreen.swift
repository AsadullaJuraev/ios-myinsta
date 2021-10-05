//
//  HomeLikesScreen.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 27/09/21.
//

import SwiftUI

struct HomeLikesScreen: View {
    @ObservedObject var viewModel = LikesViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(viewModel.items, id:\.self){ item in
                        PostCell(post: item).listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Likes", displayMode: .inline)
        }
        .onAppear{
            viewModel.apiPostList {
                print(viewModel.items.count)
            }
        }
    }
}

struct HomeLikesScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeLikesScreen()
    }
}
