//
//  OtherProfileViewModel.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 10/10/21.
//

import Foundation
import UIKit
import SwiftUI

class OtherProfileViewModel : ObservableObject{
    @Published var isLoading = false
    @Published var isImageLoading = false
    @Published var items: [Post] = []
    @Published var following: [User] = []
    @Published var followers: [User] = []
    
    @Published var isFollowed = false
    @Published var email = ""
    @Published var displayName = ""
    @Published var imgUser = ""
    
    @Published var user: User = User()
    
    func apiPostList(uid: String){
        isLoading = true
        items.removeAll()
        
        DatabaseStore().loadPosts(uid: uid, completion: { posts in
            self.items = posts!
            self.isLoading = false
        })
    }
    
    func apiLoadUser(uid: String){
        self.isLoading = true
        self.isImageLoading = true 
        DatabaseStore().loadUser(uid: uid, completion: { user in
            self.apiPostList(uid: uid)
            self.apiLoadFollowers(uid: uid)
            self.apiLoadFollowing(uid: uid)
            self.email = (user?.email)!
            self.displayName = (user?.displayName)!
            self.imgUser = (user?.imgUser)!
            self.isFollowed = (user?.isFollowed)!
            self.user = user!
            self.isImageLoading = false
            self.isLoading = false
        })
    }
    
    
    func apiLoadFollowing(uid: String){
        isLoading = true
        following.removeAll()
        
        DatabaseStore().loadFollowing(uid: uid, completion: { users in
            self.following = users!
//            self.isLoading = false
        })
    }
    
    func apiLoadFollowers(uid: String){
        isLoading = true
        followers.removeAll()
        
        DatabaseStore().loadFollowers(uid: uid, completion: { users in
            self.followers = users!
//            self.isLoading = false
        })
    }
    
    func apiLikePost(uid: String, post: Post){
        DatabaseStore().likeFeedPost(uid: uid, post: post)
        apiPostList(uid: uid)
    }
    
    func apiFollowUser(uid: String, to: User){
        SearchViewModel().apiFollowUser(uid: uid, to: to)
        apiLoadUser(uid: to.uid!)
    }
    
    func apiUnFollowUser(uid: String, to: User){
        SearchViewModel().apiUnFollowUser(uid: uid, to: to)
        apiLoadUser(uid: to.uid!)
    }
}
