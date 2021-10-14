//
//  HomeUploadScreen.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 27/09/21.
//

import SwiftUI

struct HomeUploadScreen: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var viewModel = UploadViewModel()
    @Binding var tabSelection: Int
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State var caption = ""
    @State private var showingOptions = false
    
    func uploadPost(){
        if caption.isEmpty || selectedImage == nil{
            return
        }
        // Send post to server
        let uid = (session.session?.uid)!
        viewModel.apiUploadPost(uid: uid, caption: caption, image: selectedImage!){result in
            if result {
                self.selectedImage = nil
                self.caption = ""
                self.tabSelection = 0
            }
        }
        
    }
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    ZStack{
                        if selectedImage != nil{
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .frame(maxWidth: UIScreen.width, maxHeight: UIScreen.width)
                                .scaledToFill()
                            VStack{
                                HStack{
                                    Spacer()
                                    Button(action:{
                                        selectedImage = nil
                                    }){
                                        Image(systemName: "xmark.square")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                    }.padding()
                                }
                                Spacer()
                            }
                        }else{
                            Button(action:{
                                self.showingOptions.toggle()
                            }){
                                Image(systemName: "camera").resizable().scaledToFit()
                                    .frame(width: 40, height: 40)
                                
                            }
                            .sheet(isPresented: self.$isImagePickerDisplay) {
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
                    }
                    .frame(maxWidth: UIScreen.width, maxHeight: UIScreen.width)
                    .background(Color.gray.opacity(0.2))
                    
                    VStack{
                        TextField("Caption", text: $caption)
                            .font(Font.system(size: 17, design: .default))
                            .frame(height: 45)
                        Divider()
                        
                    }.padding(.top, 10).padding([.leading, .trailing], 20)
                    
                    Spacer()
                }
            
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(trailing:
                                    Button(action:{
                                        
                                        self.uploadPost()
                                    }){
                                        Image(systemName: "square.and.arrow.up")
                                            .font(.title3)
                                    }
            )
            .navigationBarTitle("upload", displayMode: .inline)
        }
    }
}

struct HomeUploadScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeUploadScreen(tabSelection: .constant(0))
    }
}
