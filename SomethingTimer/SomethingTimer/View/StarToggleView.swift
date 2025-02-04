//
//  StarToggleView.swift
//  SomethingTimer
//
//  Created by 정보경 on 2/4/25.
//

import SwiftUI

struct StarToggleView: View {
    
    @Binding var isFavorite: Bool
    
    var body: some View {
        Button(action: {
            isFavorite.toggle()
        }, label: {
            Image(systemName: isFavorite ? "star.fill" : "star")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(isFavorite ? .yellow : .gray)
        })
    }
}

#Preview {
    StarToggleView(isFavorite: .constant(false))
}
