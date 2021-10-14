//
//  PostCell.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 30/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeedPostCell: View {
    @State private  var showingAlert = false
    var uid: String
    var viewModel: FeedViewModel
    @State var post: Post
    @State var isPresented = false
    @Binding var tabSelection: Int
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                VStack{
                    if !post.imgUser!.isEmpty {
                        WebImage(url: URL(string: post.imgUser!))
                            .resizable().clipShape(Circle())
                            .frame(width: 46, height:46)
                            .padding(.all, 2)
                    }else{
                        Image("ic_person").resizable().clipShape(Circle())
                            .frame(width: 46, height:46)
                            .padding(.all, 2)
                    }
                }.overlay(RoundedRectangle(cornerRadius: 25).stroke(Utils.color2, lineWidth: 2))
            
                VStack(alignment: .leading, spacing: 3){
                    Button(action: {
                        if post.uid == uid {
                            tabSelection = 4
                        }else{
                            isPresented = true
                        }
                    }){
                        Text(post.displayName!)
                            .foregroundColor(.black)
                            .font(.system(size: 17))
                    }.buttonStyle(PlainButtonStyle())
                    .sheet(isPresented: $isPresented, onDismiss: {
                        isPresented = false
                    }, content: {
                        OtherProfileScreen(uid: post.uid!)
                    })
                    Text(post.time!)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                }.padding(.leading, 15)
                
                Spacer()
                Button(action:{
                    showingAlert = true
                }){
                    if uid == post.uid {
                        Image("ic_more")
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .alert(isPresented: $showingAlert, content: {
                    let title = "Delete"
                    let message = "Do you want to delete this post?"
                    return Alert(title: Text(title), message: Text(message), primaryButton: .destructive(Text("Confirm"), action: {
                        viewModel.apiRemovePost(uid: uid, post: post)
                    }), secondaryButton: .cancel())
                })
            }
            .padding([.horizontal, .top], 15)
            
            UrlImageView(urlImageModel: UrlImageModel(urlString: post.imgPost), post: post, uid: uid)
        }
        
    }
}


struct UrlImageView: View{
    @ObservedObject var urlImageModel: UrlImageModel
    @ObservedObject var viewModel = FeedViewModel()
    @ObservedObject var viewModel2 = LikesViewModel()
    @State var post: Post
    var uid : String?
    
    func actionSheet() {
        let title = post.caption!
        let img: UIImage = urlImageModel.image!
        
        let activityVC = UIActivityViewController(activityItems: [img, title], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
    var body: some View{
        VStack{
            Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
                .resizable().scaledToFit()
                .padding(.top,15)
            HStack(spacing: 0){
                Button(action:{
                    if post.isLiked! {
                        post.isLiked = false
                    }else{
                        post.isLiked = true
                    }
                    viewModel.apiLikePost(uid: uid!, post: post)
                    viewModel2.apiLikePost(uid: uid!, post: post)
                }){
                    Image("ic_like\(!post.isLiked! ? "" : "_on")")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundColor(!post.isLiked! ? .black : .red)
                    
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    actionSheet()
                }){
                    Image("ic_share")
                        .resizable()
                        .frame(width: 26, height: 26)
                    
                }.buttonStyle(PlainButtonStyle())
                .padding(.leading, 15)
                
                Spacer()
            }.padding([.horizontal, .top], 15)
            
            HStack(spacing: 0){
                Text(post.caption ?? "" )
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                Spacer()
            }.padding(15)
        }
    }
    
    static var defaultImage = UIImage(named: "loadingImage")
    
}
