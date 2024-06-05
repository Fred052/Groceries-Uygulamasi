//
//  CheckOutView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 04.06.24.
//

import SwiftUI

struct CheckOutView: View {
    
    @Binding var isShow: Bool
    
    @StateObject var cartVm = CartViewModel.shared
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack {
                HStack {
                    Text("Sepeti Onayla")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    
                    Button{
                        $isShow.wrappedValue = false
                    } label: {
                        Image("close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.top, 30)
                
                Divider()
                VStack {
                    HStack {
                        Text("Teslimat Türü")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.secondaryText)
                            .frame(height: 46)
                        
                        Spacer()
                        
                        Picker("",selection: $cartVm.deliveryType) {
                            Text("Teslimat").tag(1)
                            Text("Mağazadan Al").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 180)
                    }
                    Divider()
                    
                    if(cartVm.deliveryType == 1) {
                        
                        NavigationLink {
                            DeliveryAddressView(isPicker: true, didSelect: {
                                aObj in
                                cartVm.deliveryObj = aObj
                            })
                        } label: {
                            HStack {
                                Text("Teslimat")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.secondaryText)
                                    .frame(height: 46)
                                
                                Spacer()
                                
                                Text(cartVm.deliveryObj?.name ?? "Yöntem Seç")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                    .frame(height: 46)
                                
                                Image("next")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.primaryText)
                            }
                        }

                       
                        Divider()
                    }
                    
                    
                    HStack {
                        Text("Ödeme Türü")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.secondaryText)
                            .frame(height: 46)
                        
                        Spacer()
                        
                        Picker("",selection: $cartVm.paymentType) {
                            Text("Kapıda Öde").tag(1)
                            Text("Online").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 170)
                    }
                    
                    Divider()
                    if(cartVm.paymentType == 2) {
                        NavigationLink {
                            PaymentMethodsView(isPicker: true, didSelect: {
                                pObj in
                                cartVm.paymentObj = pObj
                            })
                        } label: {
                            HStack {
                                Text("Ödeme")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.secondaryText)
                                    .frame(height: 46)
                                
                                Spacer()
                                
                                Image("master")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 20)
                                
                                Text( cartVm.paymentObj?.cardNumber ?? "Seç")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                    .frame(height: 46)
                                
                                Image("next")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.primaryText)
                            }
                        }

                        
                        Divider()
                    }
                    
                    NavigationLink {
                        PromoCodeView(isPicker: true, didSelect: {
                            pObj in
                            cartVm.promoObj = pObj
                        })
                    } label: {
                        HStack {
                            Text("İndirim Kodu")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.secondaryText)
                                .frame(height: 46)
                            
                            Spacer()
                            
                            
                            Text(cartVm.promoObj?.code ?? "İndirim Seç")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.primaryText)
                                .frame(height: 46)
                            
                            Image("next")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.primaryText)
                        }
                    }

                    
                    Divider()
                    
                }
                VStack {
                    HStack {
                        Text("Toplam")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.secondaryText)
                        
                        Spacer()
                        
                        Text("$ \(cartVm.total)")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.secondaryText)
                    }
                    
                    
                    HStack {
                        Text("Teslimat Ücreti")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.secondaryText)
                        
                        Spacer()
                        
                        Text("+ $ \(cartVm.deliverPriceAmount)")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.secondaryText)
                    }
                    
                    HStack {
                        Text("İndirim")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.secondaryText)
                        
                        Spacer()
                        
                        Text("- $ \(cartVm.discountAmount)")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 15)
                
                HStack {
                    Text("Nihai Toplam")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.secondaryText)
                        .frame(height: 46)
                    
                    Spacer()
                    
                    
                    Text("$\(cartVm.userPayAmount)")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.primaryText)
                        .frame(height: 46)
                    
                    Image("next")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.primaryText)
                }
                
                Divider()
                
                VStack {
                    Text("Devam ederek şunları kabul etmiş olursunuz:")
                        .font(.customfont(.semibold, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Text("Kullanım Şartları")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryText)
                        
                        
                        Text("ve")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.secondaryText)
                        
                        
                        Text("Gizlilik Politikası")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                }
                .padding(.vertical, .screenWidth * 0.03)
                
                RoundButton(title: "Sipariş Vermek"){
                    cartVm.serviceCallOrderPlace()
                }
                .padding(.bottom, .bottomInsets + 70)
            }
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(20, corner: [.topLeft, .topRight])
        }
    }
}
struct CheckOutView_Previews: PreviewProvider {
    @State static var isShow: Bool = false;
    static var previews: some View {
        NavigationView {
            CheckOutView(isShow: $isShow)
        }
    }

}
