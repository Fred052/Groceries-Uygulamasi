//
//  HomeViewModel.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 14.05.24.
//

import SwiftUI

class HomeViewModel: ObservableObject
{
    static var shared: HomeViewModel = HomeViewModel()
    
    @Published var  selectTab: Int = 0
    @Published var  txtSearch: String = ""
}
