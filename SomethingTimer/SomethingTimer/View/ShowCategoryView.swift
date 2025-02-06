//
//  ShowCategoryView.swift
//  SomethingTimer
//
//  Created by 김용해 on 2/6/25.
//

import SwiftUI

struct ShowCategoryView: View {
    
    let gridItem: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4) // gridItem 배열
    var something: SomethingItem// 받아오기
//    private let detailCategorys
// Assets 가져오기
    var body: some View {
        VStack {
            Text("카테고리를 선택해 주세요!")
                .font(.title)
                .foregroundStyle(.green)
            Spacer()
            LazyVGrid(columns: gridItem, spacing: 20) {
                ForEach(0...11, id: \.self){_ in
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.white)
                        .shadow(radius: 8)
                        .frame(minHeight: 80)
                        .overlay {
                            VStack {
                                Image(systemName: "01.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("제목")
                                    .font(.callout)
                                    
                            }
                            .padding(5)
                        }
                }
            }
            .padding()
            Spacer()
            Button(action: {
                
            }, label: {
                Text("저장")
            })
        }
    }
}

// 22개의 Assets를 가져오기 위한 Model
struct DetailCategoryModel {
    let name: String
    let imageName: String
}



#Preview {
    ShowCategoryView(something:
                        SomethingItem(title: "Hello, World!!", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer, categoryMainFood: .KoreanFood))
    )
}
