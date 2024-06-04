//
//  AddPaymentMethodView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 04.06.24.
//

import SwiftUI

struct AddPaymentMethodView: View {
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
    @StateObject var payVM = PaymentViewModel.shared
    
    var body: some View {
        ZStack {
            
            ScrollView{
                VStack(spacing: 15) {
                    
                    LineTextField(title: "İsim",placholder: "İsminizi Giriniz" ,txt: $payVM.txtName)
                    
                    LineTextField(title: "Kart Numarası",placholder: "Kart Numaranızı Giriniz" ,txt: $payVM.txtCardNumber, keyboardType: .numberPad)
                    
                    
                    HStack {
                        LineTextField(title: "MM",placholder: " Bitme Ayı" ,txt: $payVM.txtCardMonth, keyboardType: .numberPad)
                        
                        LineTextField(title: "YYYY",placholder: "Bitme Yılı" ,txt: $payVM.txtCardYear, keyboardType: .numberPad)
                        
                    }
                    RoundButton(title:"Ödeme Yöntemi Ekle"){
                        
                            payVM.serviceCallAdd{                                self.mode.wrappedValue.dismiss()
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
                    
                    Text("Ödeme Yöntemi Ekle")
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
        
        .alert(isPresented: $payVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(payVM.errorMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    AddPaymentMethodView()
}
