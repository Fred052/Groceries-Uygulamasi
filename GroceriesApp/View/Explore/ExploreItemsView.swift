//
//  ExploreItemsView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 29.05.24.
//

import SwiftUI

struct ExploreItemsView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var itemsVM = ExploreItemViewModel(catObj: ExploreCategoryModel(dict: [:]))
    
    var columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    Text(itemsVM.cObj.name)
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    
                    Button {
                    } label: {
                        Image("filter_ic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
                ScrollView{
                    LazyVGrid(columns: columns,spacing: 15) {
                        ForEach(itemsVM.listArr, id: \.id) { pObj in
                            ProductCell(pObj: pObj, width: .infinity) {
                                
                            }
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .padding(.bottom, .bottomInsets + 60)
                }
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ExploreItemsView(itemsVM: ExploreItemViewModel(catObj: ExploreCategoryModel(dict: [
        "cat_id": 1,
        "cat_name": "Fresh Meyveler ve Sebze",
        "image": "http://localhost:3001/img/category/20230726155407547qM5gSxkrCh.png",
        "color": "53B175"
    ])))
}
