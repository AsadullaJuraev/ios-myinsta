//
//  MyPostCell.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 30/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyPostCell: View {
    var level: Int
    @State var isLiked = false
    var post: Post
    var length: CGFloat
    
    var body: some View {
        VStack(spacing: 0){
            WebImage(url: URL(string:post.imgUrl!))
                .resizable()
                .frame(width: length, height: length)
                .scaledToFit()
            if level == 1 {
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
                            .foregroundColor(.black)
                    }.padding(.leading, 15)
                    
                    Spacer()
                }.padding([.horizontal, .top], 15)
            }
            Text("Make a symbolic breakpoint it")
                .foregroundColor(.black)
                .font(.system(size: 16))
                .padding(.vertical, 10)
                .frame(width: length)
            
        }
    }
}
