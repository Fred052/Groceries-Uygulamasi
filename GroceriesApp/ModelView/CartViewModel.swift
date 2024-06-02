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
    
    
    init() {
        serviceCallList()
    }
    
    //MARK: serviceCall
    
    func serviceCallList() {
        ServiceCall.post(parameter: [:], path: Globs.SV_CART_LIST, isToken: true) { responseObj in
            
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.total = response.value(forKey: "total") as? String ?? "0.0"
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                            return CartItemModel(dict: obj as? NSDictionary ?? [:])
                        })
                    
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
