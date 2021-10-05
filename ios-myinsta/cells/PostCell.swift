//
//  PostCell.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 30/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostCell: View {
    var post: Post
    @State private var isLiked = false
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                VStack{
                    Image("ic_person").resizable().clipShape(Circle())
                        .frame(width: 46, height:46)
                        .padding(.all, 2)
                }.overlay(RoundedRectangle(cornerRadius: 25).stroke(Utils.color2, lineWidth: 2))
            
                VStack(alignment: .leading, spacing: 3){
                    Text(post.title!)
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                    Text(post.content!)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                }.padding(.leading, 15)
                
                Spacer()
                Button(action:{}){
                    Image("ic_more")
                        
                }
            }
            .padding([.horizontal, .top], 15)
            
            WebImage(url: URL(string: post.imgUrl!))
                .resizable().scaledToFit()
                .padding(.top,15)
            
            HStack(spacing: 0){
                Button(action:{
                    self.isLiked.toggle()
                }){
                    Image("ic_like\(!isLiked ? "" : "_on")")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundColor(!isLiked ? .black : .red)
                    
                }
                
                Button(action:{
                    
                }){
                    Image("ic_share")
                        .resizable()
                        .frame(width: 26, height: 26)
                    
                }.padding(.leading, 15)
                
                Spacer()
            }.padding([.horizontal, .top], 15)
            
            HStack(spacing: 0){
                Text("Make a symbolic breakpoint at UIView, category on UIView listed in")
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                Spacer()
            }.padding(15)
        }
    }
}
