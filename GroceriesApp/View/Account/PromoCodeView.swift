//
//  PromoCodeView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 04.06.24.
//

import SwiftUI

struct PromoCodeView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var promoVM = PromoCodeViewModel.shared
    var body: some View {
        ZStack {
            
            ScrollView{
                LazyVStack(spacing: 15) {
                    ForEach(promoVM.listArr, id: \.id, content: {
                        pObj in
                            VStack {
                                HStack {
                                    Text(pObj.title)
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    
                                    Text(pObj.code)
                                        .font(.customfont(.bold, fontSize: 15))
                                        .foregroundColor(.primaryApp)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(Color.secondaryText.opacity(0.3))
                                        .cornerRadius(5)
                                }
                                
                                Text(pObj.description)
                                    .font(.customfont(.medium, fontSize: 14))
                                    .foregroundColor(.secondaryText)
                                    .multilineTextAlignment(.leading)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                HStack {
                                    Text("Son Kullanım Tarihi")
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .padding(.vertical, 8)
                                        
                                    
                                    Text(pObj.endDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                                        .font(.customfont(.bold, fontSize: 12))
                                        .foregroundColor(.secondaryText)
                                        .padding(.vertical, 8)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }
                                
                            }
                            .padding(15)
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.15), radius: 2)
                            
                        
                        
                       
                        
                    })
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
                
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
                        
                        Text("Teslimat Adresi")
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
        .onAppear{
          
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    PromoCodeView()
}
