//
//  OrderAcceptView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 05.06.24.
//

import SwiftUI

struct OrderAcceptView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack {
                Spacer()
                Image("order_accpeted")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .screenWidth * 0.7)
                    .padding(.bottom, 32)
                
                Text("Siparişiniz kabul edildi")
                    .font(.customfont(.semibold, fontSize: 28))
                    .foregroundColor(.primaryText)
                    .padding(.bottom, 12)
                
                Text("Siparişiniz alındı gönderim \naşamasındadır")
                    .multilineTextAlignment(.center )
                    .font(.customfont(.semibold, fontSize: 16))
                    .foregroundColor(.secondaryText)
                    .padding(.bottom, 12)
                
                Spacer()
                Spacer()
                
                RoundButton(title: "Siparişini takip et") {
                    
                }
                
                Button{
                    mode.wrappedValue.dismiss()
                }label: {
                    Text("Ana sayfaya geri dön")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.primaryApp)
                        .padding(.vertical, 15)
                }
                .padding(.bottom, .bottomInsets + 15)
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    OrderAcceptView()
}
