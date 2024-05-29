//
//  MainTabView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 13.05.24.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var homeVM = HomeViewModel.shared
    
    var body: some View {
        ZStack {
            if(homeVM.selectTab == 0) {
                HomeView()
            }else if(homeVM.selectTab == 1) {
                ExploreView()
            }else if(homeVM.selectTab == 2) {
                ExploreView()
            }else if(homeVM.selectTab == 3) {
                FavouriteView()
            }else if(homeVM.selectTab == 4) {
                ExploreView()
            }
            VStack {
                
                Spacer()
                    
                HStack {
                    TabButton(title: "Magaza", icon: "store_tab", isSelect: homeVM.selectTab == 0) {
                       
                        DispatchQueue.main.async {
                            
                            withAnimation {
                                homeVM.selectTab = 0
                            }
                        }
                    }
                    TabButton(title: "Ürün ara", icon: "explore_tab", isSelect: homeVM.selectTab == 1) {
                        DispatchQueue.main.async {
                            
                            withAnimation {
                                homeVM.selectTab = 1
                            }
                        }
                    }
                    
                    TabButton(title: "Sepetim", icon: "cart_tab", isSelect: homeVM.selectTab == 2) {
                        DispatchQueue.main.async {
                            
                            withAnimation {
                                homeVM.selectTab = 2
                            }
                        }
                    }
                    TabButton(title: "Favorilerim", icon: "fav_tab", isSelect: homeVM.selectTab == 3) {
                        DispatchQueue.main.async {
                            
                            withAnimation {
                                homeVM.selectTab = 3
                            }
                        }
                    }
                    TabButton(title: "Hesabım", icon: "account_tab", isSelect: homeVM.selectTab == 4) {
                        DispatchQueue.main.async {
                            
                            withAnimation {
                                homeVM.selectTab = 4
                            }
                        }
                    }
                 
                }
                .padding(.top, 10)
                .padding(.bottom, .bottomInsets)
                .padding(.horizontal, 10)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: -2)
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
