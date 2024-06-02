//
//  FavouriteView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 29.05.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavouriteView: View {
    
    @State var favVm = FavoutireViewModel.shared
    var body: some View {
        ZStack {
            
            ScrollView{
                LazyVStack {
                    ForEach(favVm.listArr, id: \.id, content: {
                        fObj in
                        
                        FavouriteRow(fObj: fObj)
                        
                    })
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
                
        }
            
            VStack {
                HStack {
                    
                    Spacer()
                    
                    Text("Favorites")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                        Spacer()
                }
                .padding(.top, .topInsets)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2)
                
                Spacer()
                
                RoundButton(title: "Kart Ekle")
                    .padding(.horizontal,20)
                    .padding(.bottom, .bottomInsets + 80)
            }
           
        }
        .onAppear{
            favVm.serviceCallList()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    FavouriteView()
}
