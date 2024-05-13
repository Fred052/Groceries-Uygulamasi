//
//  MainTabView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 13.05.24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        ZStack {
            VStack {
//                Spacer()
                
                HStack {
                    Button{
                        MainViewModel.shared.isUserLogin = false
                    }label: {
                        Text("LogOut")
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    MainTabView()
}
