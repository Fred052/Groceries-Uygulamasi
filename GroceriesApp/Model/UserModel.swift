//
//  UserModel.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 13.05.24.
//

import SwiftUI

struct UserModel: Identifiable, Equatable {
    
    var id: Int = 0
    var username: String = ""
    var name: String = ""
    var email: String = ""
    var mobile: String = ""
    var mobile_code: String = ""
    var auth_token: String = ""
    
    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "user_id") as? Int ?? 0
        self.username = dict.value(forKey: "username") as? String ?? ""
        self.name = dict.value(forKey: "name") as? String ?? ""
        self.email = dict.value(forKey: "email") as? String ?? ""
        self.mobile = dict.value(forKey: "mobile") as? String ?? ""
        self.mobile_code = dict.value(forKey: "mobile_code") as? String ?? ""
        self.auth_token = dict.value(forKey: "auth_token") as? String ?? ""
    }
   
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
        
    }
}
