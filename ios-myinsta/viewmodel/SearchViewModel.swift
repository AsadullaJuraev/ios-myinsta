//
//  SearchViewModel.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 30/09/21.
//

import Foundation

class SearchViewModel: ObservableObject{
    @Published var isLoading = false
    @Published var items: [User] = []
    
    func apiUserList(completion: @escaping () -> ()){
        isLoading = true
        items.removeAll()
        
        self.items.append(User(uid: "1", displayName: "juraev", email: "tezkormedia@gmail.com"))
        self.items.append(User(uid: "1", displayName: "juraev", email: "tezkormedia@gmail.com"))
        self.items.append(User(uid: "1", displayName: "juraev", email: "tezkormedia@gmail.com"))
        self.items.append(User(uid: "1", displayName: "juraev", email: "tezkormedia@gmail.com"))
        self.items.append(User(uid: "1", displayName: "juraev", email: "tezkormedia@gmail.com"))
        self.items.append(User(uid: "1", displayName: "juraev", email: "tezkormedia@gmail.com"))
        self.items.append(User(uid: "1", displayName: "juraev", email: "tezkormedia@gmail.com"))
        self.items.append(User(uid: "1", displayName: "juraev", email: "tezkormedia@gmail.com"))
        self.items.append(User(uid: "1", displayName: "juraev", email: "tezkormedia@gmail.com"))
        
        isLoading = false
        completion()
    }
}
