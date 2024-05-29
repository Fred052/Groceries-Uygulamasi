//
//  ProductDetailView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 26.05.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    @Environment(\.presentationMode)  var mode: Binding<PresentationMode>
    @StateObject var detailVm: ProductDetailViewModel = ProductDetailViewModel(prodObj: ProductModel(dict: [:]))
    
    var body: some View {
        ZStack {
            
            ScrollView {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(hex: "F2F2F2"))
                        .frame(width: .screenWidth, height: .screenWidth * 0.8)
                        .cornerRadius(20, corner: [.bottomLeft, .bottomRight])
                    
                    WebImage(url: URL(string: detailVm.pObj.image))
                        .resizable()
                        .indicator(.activity) // Activity Indicator
                        .transition(.fade(duration: 0.5))
                        .scaledToFit()
                        .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.8)
                }
                .frame(width: .screenWidth, height: .screenWidth * 0.8)
                
                VStack {
                    HStack {
                        Text(detailVm.pObj.name)
                            .font(.customfont(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Button{
                            detailVm.isFav = !detailVm.isFav
                        }label: {
                            Image(detailVm.isFav ? "favorite" : "fav")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25 )
                        }
                        .foregroundColor(Color.secondaryText)
                    }
                    
                    Text("\(detailVm.pObj.unitValue)\(detailVm.pObj.unitName), Fiyatı")
                        .font(.customfont(.medium, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        
                        Button{
                            detailVm.addSubQTY(isAdd: false)
                        }label: {
                            Image("subtack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding(10)
                        }
                        
                        Text("\(detailVm.qty)")
                            .font(.customfont(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .multilineTextAlignment(.center)
                            .frame(width: 45, height: 45, alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke( Color.placeHolder.opacity(0.5), lineWidth: 1)
                                )
                        
                        
                        Button{
                            detailVm.addSubQTY(isAdd: true)
                        }label: {
                            Image("add_green")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding(10)
                        }
                        
                        Spacer()
                        Text("$\((detailVm.pObj.offerprice ?? detailVm.pObj.price) * Double(detailVm.qty), specifier: "%.2f")")
                            .font(.customfont(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                 
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                VStack {
                    HStack {
                        Text("Ürün Detayları")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Button{
                            withAnimation {
                                detailVm.showDetail()
                            }
                           
                        }label: {
                            Image(detailVm.isShowDetail ? "Next" : "detail_open")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15 )
                                .padding(15)
                        }
                        .foregroundColor(Color.primaryText)
                    }
                    
                    if(detailVm.isShowDetail) {
                        Text(detailVm.pObj.detail)
                            .font(.customfont(.medium, fontSize: 13))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                    }
                  
                    
                    
                    Divider()
                }
                .padding(.horizontal, 20)
                
                
                
                VStack {
                    HStack {
                        Text("Besin Değerler")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Text(detailVm.pObj.nutritionWeight)
                            .font(.customfont(.semibold, fontSize: 10))
                            .foregroundColor(.secondaryText)
                            .padding(8)
                            .background(Color.placeHolder.opacity(0.5))
                            .cornerRadius(5)
                          
                        
                        Button{
                            withAnimation {
                                detailVm.showNutrition()
                            }
                           
                        }label: {
                            Image(detailVm.isShowNutrition ? "Next" : "detail_open")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15 )
                                .padding(15)
                        }
                        .foregroundColor(Color.primaryText)
                    }
                    
                    if(detailVm.isShowNutrition) {
                        LazyVStack {
                            ForEach(detailVm.nutritionArr, id: \.id) { nObj in
                                HStack {
                                    Text(nObj.nutritionName)
                                        .font(.customfont(.semibold, fontSize: 15))
                                        .foregroundColor(.secondaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(nObj.nutritionValue)
                                        .font(.customfont(.semibold, fontSize: 15))
                                        .foregroundColor(.primaryText)
                                }
                                Divider()
                            }
                            .padding(.vertical, 0)
                        }
                        .padding(.horizontal,20)
                    }
                  
                    
                    
                    Divider()
                }
                .padding(.horizontal, 20)
                
                
                HStack {
                    Text("Değerlendirme")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 2){
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.orange)
                                .frame(width: 15, height: 15)
                        }
                    }
                    
                    Divider()
                   
                    
                    Button{
                       
                    }label: {
                        Image("detail_open")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15 )
                            .padding(15)
                    }
                    .foregroundColor(Color.primaryText)
                }
                .padding(.horizontal, 20)
                
                RoundButton(title: "Sepete Ekle") {
                        
                }
                .padding(20)
                
                
            }
            
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    Spacer()
                    
                    Button {
                    } label: {
                        Image("share")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
            
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ProductDetailView(detailVm: ProductDetailViewModel(prodObj: ProductModel(dict: [
        
            "offer_price": 2.49,
            "start_date": "2024-05-21T18:30:00.000Z",
            "end_date": "2025-08-12T18:30:00.000Z",
            "prod_id": 5,
            "cat_id": 1,
            "brand_id": 1,
            "type_id": 1,
            "name": "Organic Banana",
            "detail": "banana, fruit of the genus Musa, of the family Musaceae, one of the most important fruit crops of the world. The banana is grown in the tropics, and, though it is most widely consumed in those regions, it is valued worldwide for its flavour, nutritional value, and availability throughout the year",
            "unit_name": "kg",
            "unit_value": "1",
            "nutrition_weight": "200g",
            "price": 2.99,
            "image": "http://localhost:3001/img/product/202307310947354735xuruflIucc.png",
            "cat_name": "Frash Fruits & Vegetable",
            "type_name": "Pulses",
            "is_fav": 1
        
    ] )))
}
