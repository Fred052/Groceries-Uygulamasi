//
//  CartItemRow.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 29.05.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartItemRow: View {
        
    @State var cObj: CartItemModel = CartItemModel(dict: [:])
        
        var body: some View {
            VStack {
                HStack(spacing: 15){
                    
                    WebImage(url: URL(string: cObj.image))
                        .resizable()
                        .indicator(.activity) // Activity Indicator
                        .transition(.fade(duration: 0.5))
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    VStack(spacing: 4) {
                        
                        HStack {
                            Text(cObj.name)
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(.primaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                CartViewModel.shared.serviceCallRemove(cObj: cObj)
                            } label: {
                                Image("close")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                            }
                        }
                
                        Text("\(cObj.unitValue)\(cObj.unitName), fiyatı")
                            .font(.customfont(.medium, fontSize: 16))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                        
                        HStack {
                            Button{
                                CartViewModel.shared.serviceCallUpdateQty(cObj: cObj, newQty: cObj.qty - 1)
                            }label: {
                                Image("subtack")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke( Color.placeHolder.opacity(0.5), lineWidth: 1)
                                )
                            
                            Text("\(cObj.qty)")
                                .font(.customfont(.bold, fontSize: 24))
                                .foregroundColor(.primaryText)
                                .multilineTextAlignment(.center)
                                .frame(width: 25, height: 25, alignment: .center)
                                
                            
                            
                            Button{
                                CartViewModel.shared.serviceCallUpdateQty(cObj: cObj, newQty: cObj.qty + 1)
                            }label: {
                                Image("add_green")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke( Color.placeHolder.opacity(0.5), lineWidth: 1)
                                )
                            
                            Spacer()
                            Text("$\(cObj.offerprice ?? cObj.price, specifier: "%.2f")")
                                .font(.customfont(.semibold, fontSize: 20))
                                .foregroundColor(.primaryText)
                        }
                    }
                }
                Divider()
            }
        }
    }

#Preview {
    CartItemRow(cObj: CartItemModel(dict: [
        "cart_id": 36,
                    "user_id": 2,
                    "prod_id": 5,
                    "qty": 1,
                    "cat_id": 1,
                    "brand_id": 1,
                    "type_id": 1,
                    "name": "Organik Muz",
                    "detail": "Muz, Musaceae familyasının Musa cinsinin meyvesi, dünyanın en önemli meyve bitkilerinden biri. Muz tropik bölgelerde yetişir ve en çok bu bölgelerde tüketilmesine rağmen lezzeti, besin değeri ve yıl boyunca bulunabilirliği nedeniyle dünya çapında değerlidir.",
                    "unit_name": "kg",
                    "unit_value": "1",
                    "nutrition_weight": "200g",
                    "price": 2.99,
                    "created_date": "2023-07-31T04:17:35.000Z",
                    "modify_date": "2023-07-31T04:17:35.000Z",
                    "cat_name": "Fresh Meyveler ve Sebze",
                    "is_fav": 1,
                    "brand_name": "bigs",
                    "type_name": "Pulses",
                    "offer_price": 2.49,
                    "start_date": "2024-05-22 00:00:00",
                    "end_date": "2025-08-13 00:00:00",
                    "is_offer_active": 1,
                    "image": "http://localhost:3001/img/product/202307310947354735xuruflIucc.png",
                    "item_price": 2.49,
                    "total_price": 2.49]))
    .padding(.horizontal, 20)
}
