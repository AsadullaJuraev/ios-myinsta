//
//  LikePostCell.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 07/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct LikePostCell: View {
    @State private  var showingAlert = false
    var uid: String
    var viewModel: LikesViewModel
    @State var post: Post
    @State private var isLiked = false
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                VStack{
                    if !post.imgUser!.isEmpty {
                        WebImage(url: URL(string: post.imgUser!))
                            .resizable().clipShape(Circle())
                            .frame(width: 46, height:46)
                            .padding(.all, 2)
                    }else{
                        Image("ic_person").resizable().clipShape(Circle())
                            .frame(width: 46, height:46)
                            .padding(.all, 2)
                    }
                }.overlay(RoundedRectangle(cornerRadius: 25).stroke(Utils.color2, lineWidth: 2))
            
                VStack(alignment: .leading, spacing: 3){
                    Text(post.displayName!)
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                    Text(post.time!)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                }.padding(.leading, 15)
                
                Spacer()
                Button(action:{
                    showingAlert = true
                }){
                    if uid == post.uid {
                        Image("ic_more")
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .alert(isPresented: $showingAlert, content: {
                    let title = "Delete"
                    let message = "Do you want to delete this post?"
                    return Alert(title: Text(title), message: Text(message), primaryButton: .destructive(Text("Confirm"), action: {
                        viewModel.apiRemovePost(uid: uid, post: post)
                    }), secondaryButton: .cancel())
                })
            }
            .padding([.horizontal, .top], 15)
            
            UrlImageView(urlImageModel: UrlImageModel(urlString: post.imgPost), post: post, uid: uid)
        }
    }
}
