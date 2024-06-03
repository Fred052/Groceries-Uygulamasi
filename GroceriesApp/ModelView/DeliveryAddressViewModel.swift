//
//  DeliveryAddressViewModel.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 02.06.24.
//

import SwiftUI

class DeliveryAddressViewModel: ObservableObject
{
    static var shared: DeliveryAddressViewModel = DeliveryAddressViewModel()
    

    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var listArr: [AddressModel] = []
    
    init() {
        serviceCallList()
    }
    
    //MARK: serviceCall
    
    func serviceCallList() {
        ServiceCall.post(parameter: [:], path: Globs.SV_ADDRESS_LIST, isToken: true) { responseObj in
            
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                            return AddressModel(dict: obj as? NSDictionary ?? [:])
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
    
    
    func serviceCallRemove(cObj: AddressModel) {
        ServiceCall.post(parameter: ["address_id": cObj.id ], path: Globs.SV_REMOVE_ADDRESS, isToken: true) { responseObj in
            
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
    
}

