//
//  TypeModel.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 21.05.24.
//

import SwiftUI

struct TypeModel: Identifiable, Equatable {
    
    var id: Int = 0
    var name: String = ""
    var image: String = ""
    var color: Color = Color.primaryApp
    
    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "user_id") as? Int ?? 0
        self.name = dict.value(forKey: "type_name") as? String ?? ""
        self.image = dict.value(forKey: "image") as? String ?? ""
        self.color = Color(hex: dict.value(forKey: "color") as? String ?? "00000")
    }
   
    static func == (lhs: TypeModel, rhs: TypeModel) -> Bool {
        return lhs.id == rhs.id
        
    }
}

//{
//                "type_id": 1,
//                "type_name": "Pulses",
//                "image": "http://localhost:3001/img/type/202307261610181018aVOpgmY1W1.png",
//                "color": "F8A44C"
//            }
