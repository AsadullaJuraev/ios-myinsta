//
//  User.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 27/09/21.
//

import Foundation

struct User: Hashable {
    var uid: String?
    var displayName: String?
    var email: String?
    var password: String?
    var imgUser: String?
    
    init(uid: String?, displayName: String?, email: String?){
        self.uid = uid
        self.displayName = displayName
        self.email = email
    }
    
    init(email: String, displayName: String?, password: String?, imgUser: String?){
        self.email = email
        self.displayName = displayName
        self.password = password
        self.imgUser = imgUser
    }
}
