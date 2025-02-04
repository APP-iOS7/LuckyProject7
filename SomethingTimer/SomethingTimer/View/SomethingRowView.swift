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
            Text("\(item.title)")
     
        }
    }
}


#Preview {
    SomethingRowView(item: SomethingItem(title: "Hello, World!!", timeRemaining: 3600))
}
