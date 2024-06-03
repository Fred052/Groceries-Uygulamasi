//
//  DeliveryAddressView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 02.06.24.
//

import SwiftUI

struct DeliveryAddressView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var addressVM = DeliveryAddressViewModel.shared
    var body: some View {
        ZStack {
            
            ScrollView{
                LazyVStack(spacing: 15) {
                    ForEach(addressVM.listArr, id: \.id, content: {
                        aObj in
                        
                        HStack(spacing: 15) {
                            VStack {
                                HStack {
                                    Text(aObj.name)
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    
                                    Text(aObj.typeName)
                                        .font(.customfont(.bold, fontSize: 12))
                                        .foregroundColor(.primaryText)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(Color.secondaryText.opacity(0.3))
                                        .cornerRadius(5)
                                }
                                
                                Text("\(aObj.address), \(aObj.city), \(aObj.state), \(aObj.postalCode)")
                                    .font(.customfont(.medium, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                    .multilineTextAlignment(.leading)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                
                                Text(aObj.phone)
                                    .font(.customfont(.bold, fontSize: 12))
                                    .foregroundColor(.secondaryText)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }
                            
                            VStack {
                                Button{
                                    
                                }label: {
                                    Image(systemName: "pencil")
                                        .resizable()
                                        .foregroundColor(.primaryApp)
                                        .frame(width: 20, height: 20)
                                }
                                .padding(.bottom, 8)
                                
                                Button{
                                    
                                }label: {
                                    Image("close")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                }
                                Spacer()
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
                    
                    Button{
                        mode.wrappedValue.dismiss()
                    }label: {
                        Image("add_temp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .foregroundColor(.primaryText)
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
    DeliveryAddressView()
}
