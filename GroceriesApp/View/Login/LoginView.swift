//
//  LoginView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 01.04.24.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var loginVM = MainViewModel.shared;
    var body: some View {
        ZStack {
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenWidth)
            
            VStack{
                
                Image("color_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding(.bottom, .screenWidth * 0.12)
                
                Text("Loging")
                    .font(.customfont(.semibold, fontSize: 26))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
                Text("Enter your emails and password ")
                    .font(.customfont(.semibold, fontSize: 16))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, .screenWidth * 0.1)
                
                VStack {
                    Text("Email")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.textTitle)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    TextField("Enter your email address", text: $loginVM.txtEmail)
                    Divider()
                }
                Spacer()
            }
            .padding(.top, .topInsets + 64)
            .padding(.horizontal, 20)
            .padding(.bottom, .bottomInsets)
            
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
            
        }
        .background(Color.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        
    }
}

#Preview {
    LoginView()
}
