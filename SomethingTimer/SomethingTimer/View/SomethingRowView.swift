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
        ZStack {
            NavigationLink {
                SomethingDetailView(item: item)
            } label: {
                EmptyView() // 비어있는 뷰를 통해 가장 하단으로 보내서 안보이게 합니다. 이를 통해 default 디자인을 없앨 수 있습니다.
            }
            .opacity(0)
            MainDetailBox(item: item) // 메인 뷰 detailBox
        }
    }
}


#Preview {
    SomethingRowView(item: SomethingItem(title: "Hello, World!!", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer)))
}
