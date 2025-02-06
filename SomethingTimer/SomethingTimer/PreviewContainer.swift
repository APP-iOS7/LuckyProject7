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
            SomethingItem.self,
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

        
        let something: [String] = [
            "라면",
            "삶은계란",
            "러닝",
            "삼계탕",
            "파스타면",
            "녹옹"
        
            
            ]
        
        for (title) in something {
            let something = SomethingItem(title: "Hello, World!!", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer))
            container.mainContext.insert(something)
        }
        
        }
    }

