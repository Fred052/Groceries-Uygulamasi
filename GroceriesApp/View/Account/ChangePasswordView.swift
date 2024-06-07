//
//  ChangePasswordView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 07.06.24.
//

import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
    @StateObject var myVM = MyDetailViewModel.shared
    
    var body: some View {
        ZStack {
            
            ScrollView{
                VStack(spacing: 15) {
                   
                    LineSecureField(title: "Şimdiki şifre", placholder: "Şimdiki şifrenizi giriniz", txt: $myVM.txtCurrentPassword, isShowPassword: $myVM.isCurrentPassword)
                        .padding(.bottom, .screenWidth * 0.02)
                    
                    LineSecureField(title: "Yeni şifre", placholder: "Yeni şifrenizi giriniz", txt: $myVM.txtNewPassword, isShowPassword: $myVM.isNewPassword)
                        .padding(.bottom, .screenWidth * 0.02)
                    
                    LineSecureField(title: "Şifreyi Onayla", placholder: "Yeni şifreni onayla", txt: $myVM.txtConfirmPassword, isShowPassword: $myVM.isConfirmPassword)
                        .padding(.bottom, .screenWidth * 0.02)
                    
                   
                 
                    RoundButton(title: "Güncelle"){
                        myVM.serviceCallUpdate()
                    }
                    .padding(.bottom, 45)
                    
                   

                    
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
        }
            VStack {
                HStack {
                    Button{
                        mode.wrappedValue.dismiss()
                    }label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .foregroundColor(.primaryText)
                    
                    
                    Spacer()
                    
                    Text("Şifre değiştir")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                        Spacer()
                    
                    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2)
                
                
                Spacer()
                
        }

        }
        .sheet(isPresented: $myVM.isShowPicker, content: {
            CountryPickerUI(country: $myVM.countryObj)
        })
        .alert(isPresented: $myVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(myVM.errorMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ChangePasswordView()
}
