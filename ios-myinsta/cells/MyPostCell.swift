//
//  MyPostCell.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 30/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyPostCell: View {
    @State private var showingAlert = false
    var uid: String
    var viewModel: ProfileViewModel
    var post: Post
    var level: Int
    var length: CGFloat
    
    var body: some View {
        VStack(spacing: 0){
            WebImage(url: URL(string:post.imgPost!))
                .resizable()
                .frame(width: length, height: length)
                .scaledToFit()
                .onTapGesture(count: 2, perform: {
                    showingAlert = true
                })
                .alert(isPresented: $showingAlert){
                    let title = "Delete"
                    let message = "Do you want to delete this post?"
                    return Alert(title: Text(title), message: Text(message), primaryButton: .destructive(Text("Confirm"), action: {
                        viewModel.apiRemovePost(uid: uid, post: post)
                    }), secondaryButton: .cancel())
                }
            Text(post.caption ?? "")
                .foregroundColor(.black)
                .font(.system(size: 16))
                .padding(.vertical, 10)
                .frame(width: length)
            
        }
    }
}
