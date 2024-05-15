//
//  SearchTextField.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 15.05.24.
//

import SwiftUI

struct SearchTextField: View {
    @State var title: String = "Title"
    @State var placholder: String = "Placholder"
    @Binding var txt: String
    var body: some View {
        HStack(spacing: 15) {
            
            Image("search")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            
                TextField(placholder, text: $txt)
                .font(.customfont(.regular, fontSize: 17))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .frame(minWidth: 0, maxWidth: .infinity)
                
            }
        .frame(height: 30)
        .padding(15)
        .background(Color(hex: "F2F2F2"))
        .cornerRadius(16)
        }
}

struct SearchTextField_Previews: PreviewProvider {
    @State static var txt: String = ""
    static var previews: some View {
        SearchTextField(placholder: "Mağaza ara", txt: $txt)
            .padding(15)
    }

}
