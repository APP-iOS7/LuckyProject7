//
//  SomethingTimerApp.swift
//  SomethingTimer
//
//  Created by 김건 on 1/27/25.
//

import SwiftUI
import SwiftData

struct CategoryMainFoodList {
    let modelContext: ModelContext
    @AppStorage("isFirstLaunching") private var isFirstLaunching: Bool = false
    let foodCategorys: [RecipesByCategory] = [
        RecipesByCategory(selectedCategory: .KoreanFood, somethingItems: []),
        RecipesByCategory(selectedCategory: .ChineseFood, somethingItems: []),
        RecipesByCategory(selectedCategory: .JapaneseFood, somethingItems: []),
        RecipesByCategory(selectedCategory: .WesternFood, somethingItems: []),
        RecipesByCategory(selectedCategory: .SoutheastFood, somethingItems: []),
        RecipesByCategory(selectedCategory: .EtcFood, somethingItems: []),
    ]
    
    func initFoodCategory() {
        
        if !isFirstLaunching {
            for category in foodCategorys {
                modelContext.insert(category)
                print("category : \(category.selectedCategory)")
            }
            isFirstLaunching = true // 히힛
        }
    }
}

@main
struct SomethingTimerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            RecipesByCategory.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        let categoryMainFoodList: CategoryMainFoodList = CategoryMainFoodList(modelContext: sharedModelContainer.mainContext)
        categoryMainFoodList.initFoodCategory() // 초기  RecipesByCategory 생성
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(sharedModelContainer)
        }
    }
}
