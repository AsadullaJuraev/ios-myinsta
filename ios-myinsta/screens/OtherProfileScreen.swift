//
//  OtherProfileScreen.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 10/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct OtherProfileScreen: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var viewModel = OtherProfileViewModel()
    var uid : String
    @State var level = 2
    
    func postSize() -> CGFloat {
        if level == 1 {
            return UIScreen.width/CGFloat(level) - 20
        }
        return UIScreen.width/CGFloat(level) - 15
    }
    
    func columns () -> [GridItem]{
        return Array(repeating: GridItem(.flexible(minimum: postSize()), spacing: 10), count: self.level)
    }
    
    func usr_login(userLogin: String)-> String{
        var str = "@"
        if userLogin != "" {
            for i in userLogin{
                if i == " " {
                    str += "_"
                }else{
                    str += "\(i.lowercased())"
                }
            }
        }
        return str
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing: 0){
                    ZStack{
                        VStack{
                            ZStack{
                                if !viewModel.imgUser.isEmpty{
                                    WebImage(url: URL(string: viewModel.imgUser))
                                        .resizable()
                                        .clipShape(Circle())
                                        .scaledToFill()
                                        .frame(width: 70, height: 70)
                                        .padding(.all, 2)
                                }else{
                                    Image("ic_person")
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 70, height: 70)
                                        .padding(.all, 2)
                                }
                                if viewModel.isImageLoading {
                                    ProgressView()
                                }
                            }
                        }
                        .overlay(RoundedRectangle(cornerRadius: 37).stroke(Utils.color2, lineWidth: 2))
                        
                    }
                    
                    Text(viewModel.displayName)
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                        .padding(.top, 15)
                    
                    Text(viewModel.email)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                        .padding(.top, 3)
                    
                    HStack{
                        VStack{
                            Text(String(viewModel.items.count))
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                            Text("Posts")
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                        }.frame(maxWidth: UIScreen.width/3, maxHeight: 60)
                        
                        VStack{}.frame(maxWidth: 1, maxHeight: 25)
                            .background(Color.gray.opacity(0.5))
                        
                        VStack{
                            Text(String(viewModel.followers.count))
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                            Text("Followers")
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                        }.frame(maxWidth: UIScreen.width/3, maxHeight: 60)
                        
                        VStack{}.frame(maxWidth: 1, maxHeight: 25)
                            .background(Color.gray.opacity(0.5))
                        
                        VStack{
                            Text(String(viewModel.following.count))
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                            Text("Following")
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                        }.frame(maxWidth: UIScreen.width/3, maxHeight: 60)
                        
                        
                    }.padding(.top, 10)
                    Button(action:{
                        if isFollowed(uid: uid) {
                            viewModel.apiUnFollowUser(uid: (session.session?.uid)!, to: viewModel.user)
                            isFollowed(uid: uid)
                        }else{
                            viewModel.apiFollowUser(uid: (session.session?.uid)!, to: viewModel.user)
                            isFollowed(uid: uid)
                        }
                    }){
                        Text(isFollowed(uid: uid) ? "Following" : "Follow")
                            .font(.system(size: 15))
                            .foregroundColor(isFollowed(uid: uid) ? .black.opacity(0.5) : .white)
                            .frame(width: 90, height: 30)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(isFollowed(uid: uid) ? Color.gray : Color.white, lineWidth: 1))
                            .background(isFollowed(uid: uid) ? .white : Utils.color2)
                            .cornerRadius(5)
                    }
                    HStack{
                        Spacer()
                        Button(action:{
                            level = 1
                        }){
                            Image(systemName: "rectangle.grid.1x2")
                                .font(.title2)
                        }
                        Spacer()
                        Button(action:{
                            level = 2
                        }){
                            Image(systemName: "square.grid.2x2")
                                .font(.title2)
                        }
                        Spacer()
                    }.padding(5)
                    
                    ScrollView{
                        LazyVGrid(columns: columns(), spacing: 10){
                            ForEach(0..<viewModel.items.count, id:\.self){ item in
                                if uid != nil {
                                    OtherPostCell(viewModel: viewModel, post: viewModel.items[item],  length: postSize())
                                    if level == 1 {
                                        Divider()
                                    }
                                }
                            }
                        }
                    }.padding(.top, 10)
                    
                }.padding(.all, 20)
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading:
                                    Text(usr_login(userLogin: viewModel.displayName))
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
            )
        }.onAppear{
            if uid != nil {
                viewModel.apiLoadUser(uid:uid)
            }
            
        }
    }
    
    func isFollowed(uid: String)-> Bool {
        
        for user in viewModel.followers {
            if user.uid == (session.session?.uid)! {
                return true
            }
        }
        
        return false
    }
}

