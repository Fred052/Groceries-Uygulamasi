//
//  ProductCell.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 15.05.24.
//

import SwiftUI
import SDWebImageSwiftUI
struct ProductCell: View {
    @State var  pObj: ProductModel = ProductModel(dict: [:])
    var didAddCart: ( ()->() )?
    
    var body: some View {
        VStack {
            
            WebImage(url: URL(string: pObj.image))
                .resizable()
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 100, height: 80)
            
            Spacer()
            
            Text(pObj.name)
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Text("\(pObj.unitValue)\(pObj.unitName), fiyatı")
                .font(.customfont(.medium, fontSize: 16))
                .foregroundColor(.secondaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            HStack {
                Text("$\(pObj.offerprice ?? pObj.price, specifier: "%.2f")")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Button {
                    didAddCart?()
                } label: {
                    Image("add")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                    
                }
                .frame(width: 40, height: 40)
                .background(Color.primaryApp)
                .cornerRadius(15)

            }

        }
        .padding(15)
        .frame(width: 180, height: 230)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke( Color.placeHolder.opacity(0.5), lineWidth: 1)
            )
    }
}

#Preview {
    ProductCell(pObj: ProductModel(dict: ["prod_id": 5,
                                          "cat_id": 1,
                                          "brand_id": 1,
                                          "type_id": 1,
                                          "name": "Organic Banana",
                                          "detail": "banana, fruit of the genus Musa, of the family Musaceae, one of the most important fruit crops of the world. The banana is grown in the tropics, and, though it is most widely consumed in those regions, it is valued worldwide for its flavour, nutritional value, and availability throughout the year",
                                          "unit_name": "pcs",
                                          "unit_value": "7",
                                          "nutrition_weight": "200g",
                                          "price": 2.99,
                                          "image": "http://localhost:3001/img/product/202307310947354735xuruflIucc.png",
                                          "cat_name": "Frash Fruits & Vegetable",
                                          "type_name": "Pulses",
                                          "is_fav": 1])) {
        
    }
}
