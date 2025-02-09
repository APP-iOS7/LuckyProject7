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
            RecipesByCategory(selectedCategory: .KoreanFood, somethingItems: [SomethingItem(title: "123", cellInfo: [], isFavorite: true, categories: Categorys(), selectedImage: Data())]),
            RecipesByCategory(selectedCategory: .ChineseFood, somethingItems: []),
            RecipesByCategory(selectedCategory: .JapaneseFood, somethingItems: []),
            RecipesByCategory(selectedCategory: .WesternFood, somethingItems: []),
            RecipesByCategory(selectedCategory: .SoutheastFood, somethingItems: []),
            RecipesByCategory(selectedCategory: .EtcFood, somethingItems: []),
        ]
        

        for something in something {
            let recipes = something
            container.mainContext.insert(recipes)
        }
        
        }
    }

