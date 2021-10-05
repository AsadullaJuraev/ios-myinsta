//
//  UserCell.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 30/09/21.
//

import SwiftUI

struct UserCell: View {
    var user: User
    var body: some View {
        HStack(spacing: 0){
            VStack{
                Image("ic_person").resizable().clipShape(Circle())
                    .frame(width: 46, height: 46)
                    .padding(.all, 2)
            }.overlay(RoundedRectangle(cornerRadius: 25).stroke(Utils.color2, lineWidth: 2))
            
            VStack(alignment: .leading, spacing: 3){
                Text(user.displayName!)
                    .foregroundColor(.black)
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                
                Text(user.email!)
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
            }.padding(.leading, 15)
            
            Spacer()
            
            Button(action:{}){
                Text("Following")
                    .font(.system(size: 15))
                    .foregroundColor(.black.opacity(0.5))
                    .frame(width: 90, height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
            }
        }.padding(.all, 20)
    }
}
