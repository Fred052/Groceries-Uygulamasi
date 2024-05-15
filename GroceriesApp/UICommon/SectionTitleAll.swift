//
//  SectionTitleAll.swift
//  GroceriesApp
//
//  Created by Ferid Suleymanzade on 15.05.24.
//

import SwiftUI

struct SectionTitleAll: View {
    
    @State var title: String = "Title"
    @State var titleAll: String = "View All"
    var didTab : (()->())?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.customfont(.bold, fontSize: 30))
                .foregroundColor(.primaryText)
            Spacer()
            
            Text(titleAll)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.primaryApp)
        }
        .frame(height: 40)
    }
}

#Preview {
    SectionTitleAll()
        .padding(20)
}
