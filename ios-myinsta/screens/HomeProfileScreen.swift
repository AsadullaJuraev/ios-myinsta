//
//  HomeProfileScreen.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 27/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeProfileScreen: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var viewModel = ProfileViewModel()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var showingOptions = false
    @State private var showingAlert = false
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
    
    func uploadImage(){
        let uid = (session.session?.uid)!
        viewModel.apiUploadMyImage(uid: uid, image: selectedImage!)
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
                        
                        HStack{
                            Spacer()
                            VStack(alignment: .trailing){
                                Spacer()
                                Button(action: {
                                    self.showingOptions.toggle()
                                }, label: {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                })
                                .sheet(isPresented: self.$isImagePickerDisplay, onDismiss: uploadImage) {
                                    ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                                }
                                .actionSheet(isPresented: $showingOptions) {
                                    ActionSheet(
                                        title: Text("Actions"),
                                        buttons: [
                                            .default(Text("pick_photo")) {
                                                sourceType = .photoLibrary
                                                self.isImagePickerDisplay.toggle()
                                            },
                                            .default(Text("take_photo")) {
                                                sourceType = .camera
                                                self.isImagePickerDisplay.toggle()
                                            },
                                            .cancel(),
                                        ]
                                    )
                                }
                            }
                        }.frame(width: 77, height: 77)
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
                                if let uid = session.session?.uid! {
                                    MyPostCell(uid: uid, viewModel: viewModel, post: viewModel.items[item], level: level, length: postSize())
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
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action:{
                self.showingAlert = true
            }){
                Image(systemName: "pip.exit")
                    .font(.title3)
            }
                                    .alert(isPresented: $showingAlert, content: {
               
                return Alert(title: Text("sign_out"), message: Text("sign_out_text"), primaryButton: .destructive(Text("confirm"), action: {
                    viewModel.apiSignOut()
                }), secondaryButton: .cancel())
            }
)
            )
        }.onAppear{
            let uid = (session.session?.uid)!
            viewModel.apiLoadUser(uid:uid)
        }
    }
}

struct HomeProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeProfileScreen()
    }
}
