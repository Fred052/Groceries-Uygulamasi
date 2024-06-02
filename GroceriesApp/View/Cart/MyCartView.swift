//
//  MyCartView.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 29.05.24.
//

import SwiftUI

struct MyCartView: View {
    @StateObject var cartVm = CartViewModel.shared
    var body: some View {
        ZStack {
            
            if(cartVm.listArr.count == 0) {
                Text("Sepetiniz Boş")
                    .font(.customfont(.bold, fontSize: 20))
            }
            ScrollView{
                LazyVStack {
                    ForEach(cartVm.listArr, id: \.id, content: {
                        cObj in
                        
                        CartItemRow(cObj: cObj)
                        
                    })
                    .padding(.vertical, 8)
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
                
        }
            
            VStack {
                HStack {
                    
                    Spacer()
                    
                    Text("Sepetim")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                        Spacer()
                }
                .padding(.top, .topInsets)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2)
                
                Spacer()
                if(cartVm.listArr.count > 0) {
                    Button{

                    } label: {
                        ZStack {
                            Text("Sepeti Onayla")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            HStack {
                                Spacer()
                                Text("$\(cartVm.total)")
                                    .font(.customfont(.semibold, fontSize: 15))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.darkGray.opacity(0.2))
                                    .cornerRadius(5)
                            }
                            .padding(.trailing)
                        }
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .background(Color.primaryApp)
                    .cornerRadius(20)
                    .padding(.horizontal,20)
                    .padding(.bottom, .bottomInsets + 80)
                }
                
            }
        }
        .onAppear {
            cartVm.serviceCallList()
        }
        .alert(isPresented: $cartVm.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text(cartVm.errorMessage), dismissButton: .default(Text("Ok")))
        })
        .ignoresSafeArea()
    }
}

struct MyCartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MyCartView()
        }
    }

}
