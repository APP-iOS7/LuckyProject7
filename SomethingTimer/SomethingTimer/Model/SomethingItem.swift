//
//  SomethingItem.swift
//  SomethingTimer
//
//  Created by 김건 on 1/27/25.
//

import Foundation
import SwiftData





@Model
final class SomethingItem {
    var id: String = UUID().uuidString
    var title: String
    @Relationship(deleteRule: .cascade) var cellInfo: [CellInfo] // 관계형 데이터
    var isFavorite: Bool
    var categories: Categorys
    var selectedImage: Data
    
    init(title: String, cellInfo: [CellInfo], isFavorite: Bool, categories: Categorys, selectedImage: Data) {
        self.title = title
        self.cellInfo = cellInfo
        self.isFavorite = isFavorite
        self.categories = categories
        self.selectedImage = selectedImage
    }
}

@Model
final class CellInfo: Identifiable {
    var id = UUID()
    var smallTitle: String
    var content: String
    var timeRemaining: Int?

    init(smallTitle: String, content: String, timeRemaining: Int? = nil) {
        self.smallTitle = smallTitle
        self.content = content
        self.timeRemaining = timeRemaining
    }
}
