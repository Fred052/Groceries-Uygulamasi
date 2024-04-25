//
//  LineTextField.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 25.04.24.
//

import SwiftUI

struct LineTextField: View {
    @Binding var txt: String
    @State var title: String = "Title"
    @state var placholder: String = "Placholder"
    var body: some View {
        VStack {
            Text(title)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.textTitle)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            TextField("Enter your email address", text: $txt)
            Divider()
        }
    }
}

#Preview {
    LineTextField()
}
