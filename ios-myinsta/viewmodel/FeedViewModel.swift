//
//  FeedViewModel.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 29/09/21.
//

import Foundation
import UIKit

class FeedViewModel: ObservableObject{
    @Published var isLoading = false
    @Published var items: [Post] = []
    @Published var photo: UIImage?
    
    func apiFeedList(uid: String){
        isLoading = true
        items.removeAll()
        DatabaseStore().loadFeeds(uid: uid, completion: { posts in
            self.items = posts!
            self.isLoading = false
        })
    }
    
    func apiLikePost(uid: String, post: Post) {
        DatabaseStore().likeFeedPost(uid: uid, post: post)
    }
    
    func apiRemovePost(uid: String, post: Post){
        DatabaseStore().removeMyPost(uid: uid, post: post)
        apiFeedList(uid: uid)
    }
}
