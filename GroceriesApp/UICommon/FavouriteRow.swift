//
//  FavouriteRow.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 29.05.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavouriteRow: View {
    
    @State var fObj: ProductModel = ProductModel(dict: [:])
    
    var body: some View {
        VStack {
            HStack(spacing: 15){
                
                WebImage(url: URL(string: fObj.image))
                    .resizable()
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 100, height: 80)
                VStack(spacing: 4) {
                    Text(fObj.name)
                        .font(.customfont(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(fObj.unitValue)\(fObj.unitName), fiyatı")
                        .font(.customfont(.medium, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                Text("$\(fObj.offerprice ?? fObj.price, specifier: "%.2f")")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    
                Image("next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
            }
            Divider()
        }
    }
}

#Preview {
    FavouriteRow()
}
