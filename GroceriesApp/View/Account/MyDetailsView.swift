//
//  MyDetailsView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 06.06.24.
//

import SwiftUI
import CountryPicker

struct MyDetailsView: View {
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
    @StateObject var myVM = MyDetailViewModel.shared
    
    var body: some View {
        ZStack {
            
            ScrollView{
                VStack(spacing: 15) {
                   
                    LineTextField(title: "İsim",placholder: "İsminizi Giriniz" ,txt: $myVM.txtName)
                    
                    VStack {
                        Text("Telefon Numarası")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.textTitle)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            
                            Button {
                                myVM.isShowPicker = true
                            } label: {
                                if let countryObj = myVM.countryObj {
                                    
                                    Text("\(countryObj.isoCode.getFlag())")
                                        .font(.customfont(.semibold, fontSize: 35))
                                    
                                    Text("+\(countryObj.phoneCode)")
                                        .font(.customfont(.semibold, fontSize: 18))
                                        .foregroundColor(.primaryText)
                                }
                                
                            }
                            
                            TextField("Telefon Numaranızı Giriniz", text: $myVM.txtMobile)
                                .keyboardType(.numberPad)
                                .frame(minWidth: 0, maxWidth: .infinity)
                            
                            
                        }
                        Divider()
                        }
                    LineTextField(title: "Kullanıcı Adı",placholder: "Kullanıcı Adınızı Giriniz" ,txt: $myVM.txtUsername)
                 
                    RoundButton(title: "Güncelle"){
                        myVM.serviceCallUpdate()
                    }
                    .padding(.bottom, 45)
                    
                    NavigationLink {
                        ChangePasswordView()
                    } label: {
                        Text("Parolayı Değiştir")
                            .font(.customfont(.bold, fontSize: 18))
                            .foregroundColor(.primaryApp)
                    }

                    
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
                    
                    Text("Detaylarım")
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

struct MyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MyDetailsView()
    }
}

