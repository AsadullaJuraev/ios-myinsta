//
//  HomeSearchScreen.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 27/09/21.
//

import SwiftUI

struct HomeSearchScreen: View {
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
                            UserCell(user: item)
                                .listRowInsets(EdgeInsets())
                                .buttonStyle(PlainButtonStyle())
                        }
                    }.listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("Search", displayMode: .inline)
        }
        .onAppear{
            viewModel.apiUserList {
                print(viewModel.items.count)
            }
        }
    }
}

struct HomeSearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchScreen()
    }
}
