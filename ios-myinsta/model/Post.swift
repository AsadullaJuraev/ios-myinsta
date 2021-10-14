//
//  Post.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 29/09/21.
//

import Foundation

struct Post: Hashable {
    var id = UUID()
    
    var postId: String? = ""
    var caption: String? = ""
    var imgPost: String? = ""
    var time: String? = "October 6, 2021"
    
    var uid: String? = ""
    var displayName: String? = "juraev00"
    var imgUser: String? = ""
    
    var isLiked: Bool? = false
    
    init(caption: String?, imgPost: String?) {
        self.caption = caption
        self.imgPost = imgPost
    }
    
    init(postId: String, caption: String?, imgPost: String?) {
        self.postId = postId
        self.caption = caption
        self.imgPost = imgPost
    }
}
