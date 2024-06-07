//
//  NotificationViewModel.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 06.06.24.
//

import SwiftUI

class NotificationViewModel: ObservableObject
{
    static var shared: NotificationViewModel = NotificationViewModel()

    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var listArr: [NotificationModel] = []
    
    init() {
        serviceCallList()
    }
    
    //MARK: serviceCall
    
    func serviceCallList() {
        ServiceCall.post(parameter: [:], path: Globs.SV_NOTIFICATION_LIST, isToken: true) { responseObj in
            
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                            return NotificationModel(dict: obj as? NSDictionary ?? [:])
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
    
    func serviceCallReadAll() {
        ServiceCall.post(parameter: [:], path: Globs.SV_NOTIFICATION_READ_ALL, isToken: true) { responseObj in
            
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
