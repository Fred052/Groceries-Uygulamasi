//
//  CartViewModel.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 29.05.24.
//

import SwiftUI

class CartViewModel: ObservableObject
{
    static var shared: CartViewModel = CartViewModel()
    

    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var listArr: [CartItemModel] = []
    @Published var total: String = "0.0"
    
    @Published var showCheckout: Bool = false
    
    @Published var showPickerAddress: Bool = false
    @Published var showPickerPayment: Bool = false
    @Published var showPickerPromoCode: Bool = false
    
    @Published var deliveryType: Int = 1
    @Published var paymentType: Int = 1
    @Published var deliveryObj: AddressModel?
    @Published var paymentObj: PaymentModel?
    @Published var promoObj: PromoCodeModel?
    
    @Published var deliverPriceAmount : String = ""
    @Published var discountAmount : String = ""
    @Published var userPayAmount : String = ""
    
    init() {
        serviceCallList()
    }
    
    //MARK: serviceCall
    
    func serviceCallList() {
        ServiceCall.post(parameter: ["promo_code_id": promoObj?.id ?? "", "delivery_type": deliveryType], path: Globs.SV_CART_LIST, isToken: true) { responseObj in
            
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.total = response.value(forKey: "total") as? String ?? "0.0"
                    self.discountAmount = response.value(forKey: "discount_amount") as? String ?? "0.0"
                    self.deliverPriceAmount = response.value(forKey: "deliver_price_amount") as? String ?? "0.0"
                    self.userPayAmount = response.value(forKey: "user_pay_price") as? String ?? "0.0"
                    
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                            return CartItemModel(dict: obj as? NSDictionary ?? [:])
                        })
                    
                }else {
                    
                    self.discountAmount = response.value(forKey: "discount_amount") as? String ?? "0.0"
                    self.deliverPriceAmount = response.value(forKey: "deliver_price_amount") as? String ?? "0.0"
                    self.userPayAmount = response.value(forKey: "user_pay_price") as? String ?? "0.0"
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    func serviceCallUpdateQty(cObj: CartItemModel, newQty:Int ) {
        ServiceCall.post(parameter: ["cart_id": cObj.cartId, "prod_id": cObj.prodId, "new_qty": newQty], path: Globs.SV_UPDATE_CART, isToken: true) { responseObj in
            
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.serviceCallList()
                    
                }else {
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    
    
    func serviceCallRemove(cObj: CartItemModel) {
        ServiceCall.post(parameter: ["cart_id": cObj.cartId, "prod_id": cObj.prodId], path: Globs.SV_REMOVE_CART, isToken: true) { responseObj in
            
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.serviceCallList()
                    
                }else {
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    func serviceCallOrderPlace() {
        
        if(deliveryType == 1 &&  deliveryObj == nil) {
            self.errorMessage = "lütfen teslimat adresini seçin"
            self.showError = true
            return
        }
        
        if(paymentType == 1 &&  paymentObj == nil) {
            self.errorMessage = "lütfen ödeme yöntemi seçin"
            self.showError = true
            return
        }
        
        ServiceCall.post(parameter: ["address_id": deliveryType == 2 ? "": "\( deliveryObj?.id ?? 0)",
                                     "deliver_type": deliveryType,
                                     "payment_type": paymentType,
                                     "pay_id": paymentType == 1 ? "": "\( paymentObj?.id ?? 0)",
                                     "promo_code_id": promoObj?.id ?? ""], path: Globs.SV_ORDER_PLACE, isToken: true) { responseObj in
            
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.deliveryObj = nil
                    self.paymentObj = nil
                    self.promoObj = nil
                    self.showCheckout = false
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Success"
                    self.showError = true
                    self.serviceCallList()
                    
                }else {
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    class func serviceCallAddToCart(prodId: Int, qty: Int, didDone: ((_ isDone: Bool,_ message: String)->())? ) {
        ServiceCall.post(parameter: ["prod_id": prodId, "qty": qty], path: Globs.SV_ADD_CART, isToken: true) { responseObj in
            
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    didDone?(true, response.value(forKey: KKey.message) as? String ?? "Done")
                }else {
                    didDone?(false, response.value(forKey: KKey.message) as? String ?? "Fail")
                }
            }
        } failure: { error in
            didDone?(false, error?.localizedDescription ?? "Fail")
        }
    }
}
