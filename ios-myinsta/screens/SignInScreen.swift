//
//  SignInScreen.swift
//  ios-myinsta
//
//  Created by Asadulla Juraev on 26/09/21.
//

import SwiftUI

struct SignInScreen: View {
    @ObservedObject var viewModel = SignInViewModel()
    
    @State private var isNotify = false
    @State var email = "tezkormedia@gmail.com"
    @State var password = "Nurmuhammad1!"
    
    func doSignIn(){
        viewModel.apiSignIn(email: email, password: password, completion: { result in
            if !result{
                isNotify = true
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
                    
                    TextField("text_email", text: $email)
                        .frame(height: 50).padding(.leading, 10)
                        .foregroundColor(.white)
                        .background(Color.white.opacity(0.4)).cornerRadius(8)
                        .padding(.top,30)
                        .autocapitalization(.none)
                    
                    SecureField("password", text: $password)
                        .frame(height: 50).padding(.leading, 10)
                        .foregroundColor(.white)
                        .background(Color.white.opacity(0.4)).cornerRadius(8)
                        .padding(.top,10)
                        .autocapitalization(.none)
                    
                    Button(action: {
                        doSignIn()
                    }){
                        Text("sign_in")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1.5)
                                    .foregroundColor(Color.white.opacity(0.4))
                            )
                    }.padding(.top, 10)
                    Spacer()
                    
                    VStack{
                        Spacer()
                    
                        HStack{
                            Text("dont_have_account").foregroundColor(.white)
                            NavigationLink(
                                destination: SignUpScreen(),
                                label: {
                                    Text("sign_up")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                })
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
        .accentColor(.white)
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
