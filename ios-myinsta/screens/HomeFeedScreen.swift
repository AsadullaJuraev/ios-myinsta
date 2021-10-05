//
//  HomeFeedScreen.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 27/09/21.
//

import SwiftUI

struct HomeFeedScreen: View {
    @Binding var tabSelection: Int
    @ObservedObject var viewModel = FeedViewModel()
    
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
            viewModel.apiPostList {
                print(viewModel.items.count)
            }
        }
    }
}

struct HomeFeedScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedScreen(tabSelection: .constant(0))
    }
}
