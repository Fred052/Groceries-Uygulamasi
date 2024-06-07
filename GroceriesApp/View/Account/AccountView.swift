//
//  AccountView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 02.06.24.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        ZStack {
            VStack {
                
                
                HStack(spacing: 15){
                    Image("appstore")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                    
                    VStack {
                        HStack {
                            Text("Farid Suleymanzade")
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(.primaryText)
                            
                            Image(systemName: "pencil")
                                .foregroundColor(.primaryApp)
                            
                            Spacer()
                        }
                        Text("faridsuleymanzade@gmail.com")
                            .font(.customfont(.regular, fontSize: 16))
                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                            .accentColor(.secondaryText)
                       
                    }
                   
                }
                .padding(.horizontal, 20)
                .padding(.top, .topInsets)
                Divider()
                
                ScrollView {
                    LazyVStack {
                        
                        VStack {
                            
                            
                            NavigationLink {
                                MyOrdersView()
                            } label: {
                                AccountRow(title: "Siparişlerim", icon: "a_order")
                            }
                            
                            NavigationLink {
                                MyDetailsView()
                            } label: {
                                AccountRow(title: "Hesabım", icon: "a_my_detail")
                            }
                            
                           
                            
                            NavigationLink {
                                DeliveryAddressView()
                            } label: {
                                AccountRow(title: "Teslimat Adresi", icon: "a_delivery_address")
                            }

                            NavigationLink {
                               PaymentMethodsView()
                            } label: {
                                AccountRow(title: "Ödeme Yöntemleri", icon: "paymenth_methods")
                            }
                            
                           
                            
                            NavigationLink {
                                PromoCodeView()
                            } label: {
                                AccountRow(title: "İndirim Kodu", icon: "a_promocode")
                            }
                            
                           
                        }
                        
                        VStack {
                            
                            NavigationLink {
                                NotificationView()
                            } label: {
                                AccountRow(title: "Bildirimler", icon: "a_noitification")
                            }
                           
                            
                            AccountRow(title: "Yardım", icon: "a_help")
                            
                            AccountRow(title: "Hakkında", icon: "a_about")
                        }
                        Button{
                            MainViewModel.shared.logout()
                        } label: {
                            ZStack {
                                Text("Çıkış Yap")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.primaryApp)
                                    .multilineTextAlignment(.center)
                                
                                HStack {
                                    Spacer()
                                    
                                    Image("logout")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .padding(.trailing, 20)
                                }
                            }
                          
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                        .background(Color(hex: "F2F3F2"))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                    }
                }
                
            }
            .padding(.bottom, .bottomInsets + 60)
        }
        .ignoresSafeArea()
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountView()
        }
    }

}
