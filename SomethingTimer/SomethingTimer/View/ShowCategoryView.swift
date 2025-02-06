//
//  ShowCategoryView.swift
//  SomethingTimer
//
//  Created by 김용해 on 2/6/25.
//

import SwiftUI

struct ShowCategoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let gridItem: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    let allCategories: [DetailCategoryModel] = {
        let cookMethods = CategoryCookMethod.allCases.map { DetailCategoryModel(name: $0.rawValue, imageName: $0.imageName, defaultColor: .red.opacity(0.3)) }
        let ingredients = Categoryingredient.allCases.map { DetailCategoryModel(name: $0.rawValue, imageName: $0.imageName, defaultColor: .blue.opacity(0.3)) }
        let foodGoals = CategoryFoodGoal.allCases.map { DetailCategoryModel(name: $0.rawValue, imageName: $0.imageName, defaultColor: .purple.opacity(0.3)) }
        let usingTool = CategoryUsingTool.allCases.map { DetailCategoryModel(name: $0.rawValue, imageName: $0.imageName, defaultColor: .green.opacity(0.3)) }
        
        return cookMethods + ingredients + foodGoals + usingTool
    }()
    
    @Binding var categories: Categorys
    
    var body: some View {
        VStack {
            Text("카테고리를 선택해 주세요!")
                .font(.title)
                .foregroundStyle(.green)
            Spacer()
            LazyVGrid(columns: gridItem, spacing: 10) {
                ForEach(allCategories, id: \.self) { category in
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.white)
                        .shadow(color: selectedColor(selectedCategory: categories, comparedCategory: category), radius: 10)
                        .frame(minWidth: 90, minHeight: 80)
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
                            updateSelectedCategory(category)
                        }
                }
            }
            .padding()
            Spacer()
            Button(action: {
                // 저장 버튼 클릭 시 처리
                dismiss()
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

    private func selectedColor(selectedCategory: Categorys, comparedCategory: DetailCategoryModel) -> Color {
        // categories 바인딩 값에 맞는 색상 반환
        if selectedCategory.categoryCookMethod?.rawValue == comparedCategory.name {
            return .red
        } else if selectedCategory.categoryIngredient?.rawValue == comparedCategory.name {
            return .blue
        } else if selectedCategory.categoryFoodGoal?.rawValue == comparedCategory.name {
            return .purple
        } else if selectedCategory.categoryUsingTool?.rawValue == comparedCategory.name {
            return .green
        }
        return comparedCategory.defaultColor
    }

    private func updateSelectedCategory(_ category: DetailCategoryModel) {
        // 선택된 카테고리에 맞게 categories 값 수정
        if categories.categoryCookMethod?.rawValue == category.name {
            categories.categoryCookMethod = nil // 이미 선택된 카테고리라면 취소
        } else if categories.categoryIngredient?.rawValue == category.name {
            categories.categoryIngredient = nil
        } else if categories.categoryFoodGoal?.rawValue == category.name {
            categories.categoryFoodGoal = nil
        } else if categories.categoryUsingTool?.rawValue == category.name {
            categories.categoryUsingTool = nil
        } else {
            
            // 선택된 카테고리 값 업데이트
            if let cookMethod = CategoryCookMethod(rawValue: category.name) {
                categories.categoryCookMethod = cookMethod
            } else if let ingredient = Categoryingredient(rawValue: category.name) {
                categories.categoryIngredient = ingredient
            } else if let foodGoal = CategoryFoodGoal(rawValue: category.name) {
                categories.categoryFoodGoal = foodGoal
            } else if let tool = CategoryUsingTool(rawValue: category.name) {
                categories.categoryUsingTool = tool
            }
        }
    }
}

// 22개의 Assets를 가져오기 위한 Model
struct DetailCategoryModel: Hashable {
    let name: String
    let imageName: String
    let defaultColor: Color
}

#Preview {
    ShowCategoryView(
        categories: .constant(Categorys(categoryCookMethod: nil, categoryIngredient: .Eggs, categoryFoodGoal: nil, categoryUsingTool: .AirFryer))
    )
}
