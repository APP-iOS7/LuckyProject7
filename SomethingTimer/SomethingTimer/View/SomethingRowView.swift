//
//  SomethingRowView.swift
//  SomethingTimer
//
//  Created by 김건 on 1/27/25.
//

import SwiftUI

struct SomethingRowView: View {
        
    let item: SomethingItem
    
    var body: some View {
        NavigationLink {
            SomethingDetailView(item: item)
        } label: {
            HStack {
                Text("\(item.title)")
                Spacer()
                    Image(systemName: item.isFavorite ? "star.fill" : "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(item.isFavorite ? .yellow : .gray)
            }
        }
    }
}


#Preview {
    SomethingRowView(item: SomethingItem(title: "Hello, World!!", timeRemaining: 3600, isFavorite: false))
}
