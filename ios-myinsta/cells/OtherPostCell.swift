//
//  OtherPostCell.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 10/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct OtherPostCell: View {
    var viewModel: OtherProfileViewModel
    var post: Post
    var length: CGFloat
    var body: some View {
        VStack(spacing: 0){
            WebImage(url: URL(string:post.imgPost!))
                .resizable()
                .frame(width: length, height: length)
                .scaledToFit()
        
            Text(post.caption ?? "")
                .foregroundColor(.black)
                .font(.system(size: 16))
                .padding(.vertical, 10)
                .frame(width: length)
            
        }
    }
}
