//
//  MainDetailBox.swift
//  SomethingTimer
//
//  Created by 김용해 on 2/4/25.
//

import SwiftUI

struct MainDetailBox: View {
    let item: SomethingItem
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.green.opacity(0.5))
            .frame(minHeight: 80, maxHeight: 80)
            .overlay {
                HStack {
                    leftTextBox // 왼쪽 글 묶음 box
                    Spacer()
                    rightImage
                }
                .padding(.horizontal)
                .overlay {
                    favoriteIcon
                        .position(x: 20, y: -10)
                }
            }
    }
    
    
    /// ** 왼쪽 Text 묶음 처리를 위한 View**
    private var leftTextBox:  some View {
        VStack(alignment: .leading) {
            Text("\(item.title)")
                .font(.title2)
                .fontWeight(.semibold)
            Text("주저리 주저리 주저리 주저리 주저리")
                .font(.caption)
                .foregroundStyle(.gray)
                .lineLimit(1)
        }
    }
    
    /// ** 오른쪽 이미지를 위한 View **
    private var rightImage: some View {
        Circle()
            .frame(maxWidth: 60, maxHeight: 60)
            .foregroundStyle(.white)
            .overlay {
                Image(systemName: "fork.knife.circle.fill")
                    .resizable()
                    .scaledToFit()
            }
    }
    
    /// **즐겨찾기 위치 조정 및 별 아이콘 **
    private var favoriteIcon: some View {
        Image(systemName: item.isFavorite ? "star.fill" : "star")
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
            .foregroundColor(item.isFavorite ? .yellow : .gray)
            .rotation3DEffect(.degrees(260), axis: (x: 5,y: -5,z : 25))
    }
}

#Preview {
    MainDetailBox(item: SomethingItem(title: "Hello, World!!", cellInfo: [CellInfo(smallTitle: "Step 1", content: "설명", timeRemaining: 60)], isFavorite: true, categories: []))
}
