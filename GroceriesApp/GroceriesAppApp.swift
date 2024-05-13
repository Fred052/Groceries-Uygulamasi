//
//  GroceriesAppApp.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 31.03.24.
//

import SwiftUI

@main
struct GroceriesAppApp: App {
    
    @StateObject var mainVM = MainViewModel.shared
    var body: some Scene {
        WindowGroup {
            NavigationView {
                
                if mainVM.isUserLogin {
                    MainTabView()
                }else {
                    WelcomeView()
                }
            }
        }
    }
}
