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
    
    init(title: String, timeRemaining: Int) {
        self.title = title
        self.timeRemaining = timeRemaining
    }
}
