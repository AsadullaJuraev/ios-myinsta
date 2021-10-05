//
//  LikesViewModel.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 30/09/21.
//

import Foundation

class LikesViewModel: ObservableObject{
    @Published var isLoading = false
    @Published var items: [Post] = []
    
    func apiPostList(completion: @escaping () -> ()){
        isLoading = true
        items.removeAll()
        
        self.items.append(Post(title: "juraev", content: "September 30, 2021", imgUrl: Utils.image1))
        self.items.append(Post(title: "juraev", content: "September 30, 2021", imgUrl: Utils.image2))
        self.items.append(Post(title: "juraev", content: "September 30, 2021", imgUrl: Utils.image1))
        self.items.append(Post(title: "juraev", content: "September 30, 2021", imgUrl: Utils.image2))
        
        isLoading = false
        completion()
    }
}
