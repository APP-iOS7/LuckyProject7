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
    let allCategories: [DetailCategoryModel] = { // 모든 카테고리 뷰를 받아서 뿌려줍니다.
        let cookMethods = CategoryCookMethod.allCases.map { DetailCategoryModel(name: $0.rawValue, imageName: $0.imageName, defaultColor: .red.opacity(0.3)) }
        let ingredients = Categoryingredient.allCases.map { DetailCategoryModel(name: $0.rawValue, imageName: $0.imageName,defaultColor: .blue.opacity(0.3)) }
        let foodGoals = CategoryFoodGoal.allCases.map { DetailCategoryModel(name: $0.rawValue, imageName: $0.imageName,defaultColor: .purple.opacity(0.3)) }
        let usingTool = CategoryUsingTool.allCases.map { DetailCategoryModel(name: $0.rawValue, imageName: $0.imageName,defaultColor: .green.opacity(0.3)) }
        
        return cookMethods + ingredients + foodGoals + usingTool
    }()
    
    @State private var categorys: Categorys

    init(something: SomethingItem) {
        self.something = something
        _categorys = State(initialValue: something.categories)
    }
    
    var body: some View {
            VStack {
                Text("카테고리를 선택해 주세요!")
                    .font(.title)
                    .foregroundStyle(.green)
                Spacer()
                LazyVGrid(columns: gridItem, spacing: 10) {
                    ForEach(allCategories, id: \.self){ category in
                        RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.white)
                        .shadow(
                            // something에 들어있는 category들을 가져와서 비교후 true면 색상 변경
                            color: selectedColor(selectedCategory: categorys, comparedCategory: category),
                            radius: 10
                        )
                        .frame(minWidth: 90,minHeight: 80)
                        .overlay {
                            VStack {
                                Image(category.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text(category.name)
                                    .font(.callout)
                                    .fontWeight(.semibold)
                            }
                        }
                        .onTapGesture {
                            guard let cookMethod = categorys.categoryCookMethod,
                                  let ingredient = categorys.categoryIngredient,
                                  let foodGoal = categorys.categoryFoodGoal,
                                  let usingTool = categorys.categoryUsingTool
                            else {
                                return
                            }
                        }
                    }
                }
                .padding()
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("저장")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .fontWeight(.medium)
                })
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(.green)
                .clipShape(.rect(cornerRadius: 8))
                .padding()
            }
    }

    //something.categories.categoryCookMethod.rawValue == category.name ? .red : .white
    /// ** Color 변환기 생성 **
    ///  레시피는 categorys를 가지고 있고 해당 enum 값들 마다 true인값이 현재 분류된 Category 이다
    private func selectedColor(selectedCategory: Categorys, comparedCategory: DetailCategoryModel) -> Color {
        if selectedCategory.categoryCookMethod?.rawValue == comparedCategory.name {
            return .red
        }else if selectedCategory.categoryIngredient?.rawValue == comparedCategory.name {
            return .blue
        }else if selectedCategory.categoryFoodGoal?.rawValue == comparedCategory.name {
            return .purple
        }else if selectedCategory.categoryUsingTool?.rawValue == comparedCategory.name {
            return .green
        }
        // 나머지 선택되지 않은 아이템은 white
        return comparedCategory.defaultColor
    }
}

// 22개의 Assets를 가져오기 위한 Model
struct DetailCategoryModel: Hashable {
    let name: String
    let imageName: String
    let defaultColor: Color
}



#Preview {
    ShowCategoryView(something:
                        SomethingItem(title: "Hello, World!!", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: nil, categoryIngredient: .Eggs, categoryFoodGoal: nil, categoryUsingTool: .AirFryer)
    ))
}
