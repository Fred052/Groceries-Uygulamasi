//
//  MyOrdersView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 05.06.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyOrdersView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var myVM = MyOrdersViewModel.shared
    var body: some View {
        ZStack {
            ScrollView{
                LazyVStack(spacing: 15) {
                    ForEach(myVM.listArr, id: \.id, content: {
                        myObj in
                        
                        NavigationLink {
                            MyOrderDetailView(detailVm: MyOrderDetailViewModel(prodObj: myObj))
                        } label: {
                            VStack {
                                HStack {
                                    Text("Sipariş No: #")
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                      
                                    Text("\(myObj.id )")
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    
                                    Text(getOrderStatus(mObj: myObj))
                                        .font(.customfont(.bold, fontSize: 16))
                                        .foregroundColor(getOrderStatusColor(mObj: myObj) )
                                }
                                
                                Text(myObj.createdDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                                    .font(.customfont(.bold, fontSize: 14))
                                    .foregroundColor(.secondaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                HStack {
                                    if let imageUrl = myObj.images.first {
                                        WebImage(url: URL(string: imageUrl))
                                            .resizable()
                                            .indicator(.activity) // Activity Indicator
                                            .transition(.fade(duration: 0.5))
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                    }
                                    VStack {
                                        HStack {
                                            Text("Ürünler:")
                                                .font(.customfont(.bold, fontSize: 14))
                                                .foregroundColor(.primaryText)
                                                
                                            Text(myObj.names ?? "")
                                                .font(.customfont(.medium, fontSize: 14))
                                                .foregroundColor(.secondaryText)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        }
                                        HStack {
                                            Text("Teslimat Türü:")
                                                .font(.customfont(.bold, fontSize: 14))
                                                .foregroundColor(.primaryText)
                                                
                                            
                                            
                                            Text(self.getDeliveryType(mObj: myObj))
                                                .font(.customfont(.medium, fontSize: 14))
                                                .foregroundColor(.secondaryText)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            
                                        }
                                        
                                        HStack {
                                            Text("Ödeme Türü:")
                                                .font(.customfont(.bold, fontSize: 14))
                                                .foregroundColor(.primaryText)
                                                
                                            
                                            
                                            Text(getPaymentType(mObj: myObj))
                                                .font(.customfont(.medium, fontSize: 14))
                                                .foregroundColor(.secondaryText)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            
                                        }
                                        
                                        HStack {
                                            Text("Ödeme Durumu:")
                                                .font(.customfont(.bold, fontSize: 14))
                                                .foregroundColor(.primaryText)
                                                
                                            
                                            
                                            Text(getPaymentStatus(mObj: myObj))
                                                .font(.customfont(.medium, fontSize: 14))
                                                .foregroundColor( getPaymentStatusColor(mObj: myObj))
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            
                                        }
                                    }
                                }
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
                        
                        Text("Siparişlerim")
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
    
    func getOrderStatus(mObj: MyOrderModel) -> String {
        switch mObj.orderStatus {
        case 1:
            return "Siparişiniz Alındı";
        case 2:
            return "Onaylandı";
        case 3:
            return "Yolda";
        case 4:
            return "İptal Et ";
        case 5:
            return "Reddedildi";
        default:
            return "" ;
        }
    }
    func getDeliveryType(mObj: MyOrderModel) -> String {
        switch mObj.deliverType {
        case 1:
            return "Teslimat";
        case 2:
            return "Hazırlanıyor";
        default:
            return "" ;
        }
    }
    
    func getPaymentType(mObj: MyOrderModel) -> String {
        switch mObj.paymentType {
        case 1:
            return "Kapıda Ödeme";
        case 2:
            return "Online Kartla Ödeme";
        default:
            return "" ;
        }
    }
    
    func getPaymentStatus(mObj: MyOrderModel) -> String {
        switch mObj.paymentStatus {
        case 1:
            return "Hazırlanıyor";
        case 2:
            return "Başarılı";
        case 3:
            return "Başarısız";
        case 4:
            return "İade edildi";
        default:
            return "" ;
        }
    }
    
    func getPaymentStatusColor(mObj: MyOrderModel) -> Color {
        
        if (mObj.paymentType == 1) {
            return Color.orange;
        }
        
        switch mObj.paymentStatus {
        case 1:
            return Color.blue;
        case 2:
            return Color.green;
        case 3:
            return Color.red;
        case 4:
            return Color.green;
        default:
            return Color.white;
        }
    }
    
    func getOrderStatusColor(mObj: MyOrderModel) -> Color {
        
        switch mObj.orderStatus {
        case 1:
            return Color.blue;
        case 2:
            return Color.green;
        case 3:
            return Color.green;
        case 4:
            return Color.red;
        case 5:
            return Color.red;
        default:
            return Color.primaryApp;
        }
    }
}

struct MyOrderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MyOrdersView()
        }
    }
}
