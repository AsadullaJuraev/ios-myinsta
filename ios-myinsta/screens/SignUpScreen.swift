//
//  SignUpScreen.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 26/09/21.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var session: SessionStore
    @ObservedObject var viewModel = SignUpViewModel()
    
    @State private var isEmailValid : Bool   = true
    @State private var isNotify: Bool = false
    @State private var showErrorAlert = false
    @State var fullname = ""
    @State var email = ""
    @State var password = ""
    @State var cpassword = ""
    
    func doSignUp(){
        viewModel.apiSignUp(email: email, password: password, completion: { result in
            if !result {
                isNotify = true
            }else{
                var user = User(email: email, displayName: fullname, password: password, imgUser: "")
                user.uid = session.session?.uid
                //viewModel.apiStoreUser(user: user)
                presentation.wrappedValue.dismiss()
            }
        })
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Utils.color1, Utils.color2]), startPoint: .top, endPoint: .bottom)
                VStack(spacing:0){
                    Spacer()
                    Text("app_name").foregroundColor(.white)
                        .font(Font.custom("Billabong", size: 45))
                    
                    TextField("fullname", text: $fullname)
                        .frame(height: 50).padding(.leading, 10)
                        .foregroundColor(.white)
                        .background(Color.white.opacity(0.4)).cornerRadius(8)
                        .padding(.top,30)
                    
                    TextField("text_email", text: $email, onEditingChanged: { (isChanged) in
                        if !isChanged {
                            if self.emailValidator(email){
                                self.isEmailValid = true
                            } else {
                                self.isEmailValid = false
                            }
                        }
                    })
                        .frame(height: 50).padding(.leading, 10)
                        .foregroundColor(.white)
                        .background(Color.white.opacity(0.4)).cornerRadius(8)
                        .padding(.top,10)
                        .autocapitalization(.none)
                    
                    if !self.isEmailValid {
                        HStack{
                            Text("Email is Not Valid")
                                .font(.callout)
                                .foregroundColor(Color.white)
                                .padding(.top, 5)
                                .padding(.leading, 10)
                            Spacer()
                        }
                        
                    }
                    VStack(spacing: 0){
                        SecureField("password", text: $password)
                            .frame(height: 50).padding(.leading, 10)
                            .foregroundColor(.white)
                            .background(Color.white.opacity(0.4)).cornerRadius(8)
                            .padding(.top,10)
                            .autocapitalization(.none)
                        if !self.passwordValidator(password) && password != "" {
                            HStack{
                                Text("Password is Not Valid")
                                    .font(.callout)
                                    .foregroundColor(Color.white)
                                    .padding(.top, 5)
                                    .padding(.leading, 10)
                                Spacer()
                                
                            }
                            
                        }
                        
                        SecureField("cpassword", text: $cpassword)
                            .frame(height: 50).padding(.leading, 10)
                            .foregroundColor(.white)
                            .background(Color.white.opacity(0.4)).cornerRadius(8)
                            .padding(.top,10)
                            .autocapitalization(.none)
                        if cpassword != "" && (password != cpassword) {
                            HStack{
                                Text("Password is Not Matched")
                                    .font(.callout)
                                    .foregroundColor(Color.white)
                                    .padding(.top, 5)
                                    .padding(.leading, 10)
                                Spacer()
                                
                                
                            }
                            
                        }
                        Button(action: {
                            
                            if password == "" || cpassword == "" {
                                showErrorAlert = true
                            }else if isEmailValid && password == cpassword{
                                doSignUp()
                            }
                        }){
                            Text("sign_up")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(lineWidth: 1.5)
                                        .foregroundColor(Color.white.opacity(0.4))
                                )
                        }.padding(.top, 10)
                            
                            .alert(isPresented: $showErrorAlert, content: {
                                Alert(title: Text("errorText_button_signUp"), message: Text("errorMessage_button_signUp"))
                            })
                    }
                    
                    Spacer()
                    
                    VStack{
                        Spacer()
                    
                        HStack{
                            Text("already_have_account").foregroundColor(.white)
                            Button(action:{
                                presentation.wrappedValue.dismiss()
                            }){
                                Text("sign_in")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                            
                        }.padding()
                    }.frame(maxWidth: .infinity, maxHeight: 80)
                    
                }.padding()
                
                if viewModel.isLoading {
                    ProgressView()
                }
                if isNotify{
                    ZStack{
                        Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                        VStack{
                            Text("errorText_button_signUp").fontWeight(.bold)
                            Text("errorMessage_server_signUp")
                            Divider()
                            Button(action: {
                                isNotify = false
                            }, label: {
                                Text("OK")
                                    .foregroundColor(.blue)
                            })
                        }
                        
                        .padding(20)
                        .frame(width: UIScreen.width / 2 + 100)
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                        )
                        
                    }
                    
                    
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        //.navigationBarBackButtonHidden(true)
        .accentColor(.white)
    }
    
    func emailValidator(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    func passwordValidator(_ string: String) -> Bool{
        if string.count < 8 {
            return false
        }
        let passwordFormate = "^[A-Z]{1}+[a-z]+[0-9]+[!]"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormate)
        return passwordPredicate.evaluate(with: string)
    }
    
//    Password Validation:
//    Vignesh123! : true
//    vignesh123 : false
//    VIGNESH123! : false
//    vignesh@ : false
//    12345678? : false
//
//    Email Validation:
//    pdponline@gmail.com : true
//    pdponlinegmail.com : false
//    pdp@online@gmail.com : false
//    pdp#online@gmail.com : false

}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
