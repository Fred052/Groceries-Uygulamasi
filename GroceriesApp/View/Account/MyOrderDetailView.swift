//
//  MyOrderDetailView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 06.06.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyOrderDetailView: View {
    @Environment(\.presentationMode)  var mode: Binding<PresentationMode>
    @StateObject var detailVm: MyOrderDetailViewModel = MyOrderDetailViewModel(prodObj: MyOrderModel(dict: [:]))
    
    var body: some View {
        ZStack {
            
            ScrollView {
                VStack {
                    HStack {
                        Text("Sipariş ID: # \(detailVm.pObj.id)")
                            .font(.customfont(.bold, fontSize: 20))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text(getPaymentStatus(mObj: detailVm.pObj))
                            .font(.customfont(.bold, fontSize: 18))
                            .foregroundColor( getPaymentStatusColor(mObj: detailVm.pObj))
                    }
                    
                    HStack {
                        Text(detailVm.pObj.createdDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                            .font(.customfont(.bold, fontSize: 12))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text(getOrderStatus(mObj: detailVm.pObj))
                            .font(.customfont(.regular, fontSize: 14))
                            .foregroundColor(getPaymentStatusColor(mObj: detailVm.pObj))
                    }
                    .padding(.bottom, 8)
                    
                    Text("\(detailVm.pObj.address), \(detailVm.pObj.city), \(detailVm.pObj.state), \(detailVm.pObj.postalCode)")
                        .font(.customfont(.regular, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .multilineTextAlignment(.leading)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    HStack {
                        Text("Teslimat Türü")
                            .font(.customfont(.medium, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text(getDeliveryType(mObj: detailVm.pObj))
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(.primaryText)
                    }
                    .padding(.bottom, 4)
                    
                    HStack {
                        Text("Ödeme Türü")
                            .font(.customfont(.medium, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text(getPaymentType(mObj: detailVm.pObj))
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(.primaryText)
                    }
                }
                .padding(15)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 2)
                .padding(.horizontal, 20)
                .padding(.top, .topInsets + 46)
                LazyVStack {
                    ForEach(detailVm.listArr,id: \.id) { pObj in
                        OrderItemRow(pObj: pObj)
                    }
                }
                
                
                VStack {
                    HStack {
                        Text("Tutar")
                            .font(.customfont(.bold, fontSize: 18))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text("\(detailVm.pObj.totalPrice, specifier: "%.2f")")
                            .font(.customfont(.medium, fontSize: 18))
                            .foregroundColor(.primaryText)
                    }
                    .padding(.bottom, 4)
                    
                    HStack {
                        Text("Gönderim Ücreti")
                            .font(.customfont(.bold, fontSize: 18))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text("+ $\(detailVm.pObj.deliverPrice ?? 0.0, specifier: "%.2f")")
                            .font(.customfont(.medium, fontSize: 18))
                            .foregroundColor(.primaryText)
                    }
                    .padding(.bottom, 4)
                    
                    HStack {
                        Text("İndirim")
                            .font(.customfont(.bold, fontSize: 18))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text("- $\(detailVm.pObj.discountPrice ?? 0.0, specifier: "%.2f")")
                            .font(.customfont(.medium, fontSize: 18))
                            .foregroundColor(.red)
                    }
                    .padding(.bottom, 4)
                    
                    Divider()
                    
                    HStack {
                        Text("Toplam")
                            .font(.customfont(.bold, fontSize: 22))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text("$\(detailVm.pObj.userPayPrice ?? 0.0, specifier: "%.2f")")
                            .font(.customfont(.medium, fontSize: 22))
                            .foregroundColor(.primaryText)
                    }
                    .padding(.bottom, 4)
                    
                    
                }
                .padding(15)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 2)
                .padding(.horizontal, 20)
                .padding(.vertical, 4)
                
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
                    
                    Text("Sipariş Detaylarım")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.primaryText)
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
            
        }
        .alert(isPresented: $detailVm.showError, content: {
            Alert(title: Text(Globs.AppName), message:  Text(detailVm.errorMessage), dismissButton: .default(Text("Ok")))
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
    
    func getOrderStatus(mObj: MyOrderModel) -> String {
        switch mObj.orderStatus {
        case 1:
            return "Siparişiniz Hazırlanıyor";
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
            return "İşleniyor...";
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

struct myOrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
    MyOrderDetailView(detailVm: MyOrderDetailViewModel(prodObj: MyOrderModel(dict: [
        "order_id": 4,
        "cart_id": "22,23",
        "total_price": 10.450000000000001,
        "user_pay_price": 11.405000000000001,
        "discount_price": 1.0450000000000002,
        "deliver_price": 2,
        "deliver_type": 1,
        "payment_type": 2,
        "payment_status": 2,
        "order_status": 1,
        "status": 1,
        "created_date": "2023-08-10T05:09:14.000Z",
        "names": "Organik Muz,Red Apple",
        "images": "http://localhost:3001/img/product/202307310947354735xuruflIucc.png,http://localhost:3001/img/product/202307310951365136W6nJvPCdzQ.png",
        "user_name": "My Home",
        "phone": "98765432102",
        "address": "246/ A, Dhutpeshwar Bldg, Girgaon Road, Near Gai Wadi, Girgaon",
        "city": "Mumbai",
        "state": "Maharashtra",
        "postal_code": "400004"
        
    ] )))
}
}
