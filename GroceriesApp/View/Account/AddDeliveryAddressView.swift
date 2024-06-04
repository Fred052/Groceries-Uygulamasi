//
//  AddDeliveryAddressView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 03.06.24.
//

import SwiftUI

struct AddDeliveryAddressView: View {
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
    @StateObject var addressVM = DeliveryAddressViewModel.shared
    @State var isEdit: Bool = false
    @State var editObj: AddressModel?
    
    var body: some View {
        ZStack {
            
            ScrollView{
                VStack(spacing: 15) {
                    HStack {
                        Button{
                            addressVM.txtTypeName = "Home"
                        } label: {
                            Image(systemName: addressVM.txtTypeName == "Home" ? "record.circle": "circle")
                            
                            Text("Ev Adresim")
                                .font(.customfont(.medium, fontSize: 16))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .foregroundColor(.primaryText)
                        
                        Button{
                            addressVM.txtTypeName = "Office"
                        } label: {
                            Image(systemName: addressVM.txtTypeName == "Office" ? "record.circle": "circle")
                            
                            Text("Ofis Adresim")
                                .font(.customfont(.medium, fontSize: 16))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .foregroundColor(.primaryText)
                    }
                    LineTextField(title: "İsim",placholder: "İsminizi Giriniz" ,txt: $addressVM.txtName)
                    
                    LineTextField(title: "Telefon Numarası",placholder: "Telefon Numaranızı Giriniz" ,txt: $addressVM.txtMobile, keyboardType: .numberPad)
                    
                    LineTextField(title: "Adres",placholder: "Adres Bilgilerinizi Giriniz" ,txt: $addressVM.txtAddress)
                    
                    HStack {
                        LineTextField(title: "Şehir",placholder: "Şehrinizi Giriniz" ,txt: $addressVM.txtCity)
                        
                        LineTextField(title: "Bölge",placholder: "Bölgenizi Giriniz" ,txt: $addressVM.txtState)
                        
                    }
                    
                   
                    LineTextField(title: "Posta Kodu",placholder: "Posta Kodunuzu Giriniz" ,txt: $addressVM.txtPostalCode)
                    
                    RoundButton(title: isEdit ? "Adres Bilgilerini Güncelle": "Adres Ekle"){
                        if(isEdit){
                            addressVM.serviceCallUpdateAddress(aObj: editObj) {
                                self.mode.wrappedValue.dismiss()
                            }
                        }else{
                            addressVM.serviceCallAddAddress {                                self.mode.wrappedValue.dismiss()
                            }
                        }
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
                    
                    Text(isEdit ? "Teslimat Adresini düzenle" : "Teslimat Adresi")
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
        .onAppear {
            if(isEdit) {
                if let aObj = editObj {
                    addressVM.setData(aObj: aObj)
                }
            }
        }
        .alert(isPresented: $addressVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(addressVM.errorMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    AddDeliveryAddressView()
}
