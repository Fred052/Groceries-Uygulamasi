//
//  MainViewModel.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 25.04.24.
//

import SwiftUI

class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    
    @Published var txtEmail: String = ""
    @Published var txtpassword: String = ""
    @Published var isShowPassword: Bool = false
}
