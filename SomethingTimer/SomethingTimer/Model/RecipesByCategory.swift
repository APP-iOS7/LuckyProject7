//
//  RecipesByCategory.swift
//  SomethingTimer
//
//  Created by 김건 on 2/6/25.
//

import SwiftData
import Foundation

@Model
final class RecipesByCategory {
    @Attribute(.unique) var id: UUID = UUID()
    var selectedCategory: CategoryMainFood
    
    //SwiftData에서 배열속성 관리 시 @Relationship 필요
    //(deleteRule: .cascade)는 RecipesByCategory 삭제될 때 연결된 something도 삭제
    @Relationship(deleteRule: .nullify) var somethingItems: [SomethingItem]
    
    init(selectedCategory: CategoryMainFood, somethingItems: [SomethingItem]) {
        self.selectedCategory = selectedCategory
        self.somethingItems = somethingItems
    }
}
