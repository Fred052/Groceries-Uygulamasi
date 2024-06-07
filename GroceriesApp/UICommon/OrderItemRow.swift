//
//  OrderItemRow.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 06.06.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderItemRow: View {
    @State var pObj: OrderItemModel = OrderItemModel(dict: [:])
    
    var body: some View {
            HStack(spacing: 15){
                
                WebImage(url: URL(string: pObj.image))
                    .resizable()
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 100, height: 80)
                VStack(spacing: 4) {
                    Text(pObj.name)
                        .font(.customfont(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(pObj.unitValue)\(pObj.unitName), fiyatı")
                        .font(.customfont(.medium, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    HStack {
                        Text("Sayı:")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Text("\( pObj.qty)")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Text("x")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Text("$ \( pObj.itemprice, specifier: "%.2f")")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                Text("$\(pObj.offerprice ?? pObj.price, specifier: "%.2f")")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
            }
            .padding(15)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.15), radius: 2)
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
    }
}

#Preview {
    OrderItemRow()
}
