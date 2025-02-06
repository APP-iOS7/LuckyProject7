//
//  PreviewContainer.swift
//  SomethingTimer
//
//  Created by 김건 on 1/27/25.
//

import Foundation
import SwiftData

@MainActor
class PreviewContainer {
    static let shared: PreviewContainer = PreviewContainer()
    
    let container: ModelContainer
    
    init() {
        let schema = Schema([
            RecipesByCategory.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true, cloudKitDatabase: .none)
        
        do {
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            insertPreviewData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
    }
    
    func insertPreviewData() {

        let something: [RecipesByCategory] = [
            RecipesByCategory(selectedCategory: .ChineseFood, somethingItems: [
                SomethingItem(title: "짜장면", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer),selectedImage: Data()),
                
                SomethingItem(title: "탕수육", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer),selectedImage: Data()),
                
                SomethingItem(title: "마라탕", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer),selectedImage: Data())
            ]),
            
            RecipesByCategory(selectedCategory: .JapaneseFood, somethingItems: [
                SomethingItem(title: "초밥", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer),selectedImage: Data()),
                
                SomethingItem(title: "라멘", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer),selectedImage: Data()),
                
                SomethingItem(title: "경단", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer),selectedImage: Data())
            ]),
            
            RecipesByCategory(selectedCategory: .KoreanFood, somethingItems: [
                SomethingItem(title: "국밥", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer),selectedImage: Data()),
                
                SomethingItem(title: "돈까스", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer),selectedImage: Data()),
                
                SomethingItem(title: "제육볶음", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer),selectedImage: Data())
            ])
        ]
        

        for something in something {
            let recipes = something
            container.mainContext.insert(recipes)
        }
        
        }
    }

