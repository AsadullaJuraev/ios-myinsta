//
//  SignUpViewModel.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 02/10/21.
//

import Foundation

class SignUpViewModel: ObservableObject{
    
    @Published var isLoading = false
    @Published var isNotify = false
    
    func apiSignUp(email: String, password: String, completion: @escaping (Bool)-> ()){
        isLoading = true
        SessionStore().signUp(email: email, password: password, handler: {( res, err) in
            self.isLoading = false
            if err != nil {
                print("Check email or password")
                self.isNotify = true
                completion(false)
            }else{
                print("User signed up")
                completion(true)
            }
        })
    }
    
}
