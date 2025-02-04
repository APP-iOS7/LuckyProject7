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
    var timeRemaining: Int
    var isFavorite: Bool
    
    init(title: String, timeRemaining: Int, isFavorite: Bool) {
        self.title = title
        self.timeRemaining = timeRemaining
        self.isFavorite = isFavorite
    }
}
