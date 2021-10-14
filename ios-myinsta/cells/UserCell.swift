//
//  UserCell.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 30/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserCell: View {
    var uid: String
    var user: User
    var viewModel: SearchViewModel
    @State var isPresented = false
    var body: some View {
        Button(action:{
            isPresented = true
        }){
        HStack(spacing: 0){
            VStack{
                if !user.imgUser!.isEmpty {
                    WebImage(url: URL(string: user.imgUser!))
                        .resizable().clipShape(Circle())
                            .frame(width: 46, height: 46)
                            .padding(.all, 2)
                }else{
                    Image("ic_person").resizable().clipShape(Circle())
                        .frame(width: 46, height: 46)
                        .padding(.all, 2)
                }
            }.overlay(RoundedRectangle(cornerRadius: 25).stroke(Utils.color2, lineWidth: 2))
            
            VStack(alignment: .leading, spacing: 3){
                Text(user.displayName!)
                    .foregroundColor(.black)
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                
                Text(user.email!)
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
            }.padding(.leading, 15)
            
            Spacer()
            
            Button(action:{
                if user.isFollowed {
                    viewModel.apiUnFollowUser(uid: uid, to: user)
                }else{
                    viewModel.apiFollowUser(uid: uid, to: user)
                }
            }){
                Text(user.isFollowed ? "Following" : "Follow")
                    .font(.system(size: 15))
                    .foregroundColor(user.isFollowed ? .black.opacity(0.5) : .white)
                    .frame(width: 90, height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(user.isFollowed ? Color.gray : Color.white, lineWidth: 1))
                    .background(user.isFollowed ? .white : Utils.color2)
                    .cornerRadius(5)
            }.buttonStyle(PlainButtonStyle())
        }.padding(.all, 20)
        }
        .sheet(isPresented: $isPresented, onDismiss: {
            isPresented = false
        }, content: {
            OtherProfileScreen(uid: user.uid!)
        })
    }
}
