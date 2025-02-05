//
//  SomethingItem.swift
//  SomethingTimer
//
//  Created by 김건 on 1/27/25.
//

import Foundation
import SwiftData


struct Categorys: Codable {
    var categoryCookMethod: CategoryCookMethod
    var categoryIngredient: Categoryingredient
    var categoryFoodGoal: CategoryFoodGoal
    var categoryUsingTool: CategoryUsingTool
    var categoryFoodType: CategoryFoodType

}


@Model
final class SomethingItem {
    var id: String = UUID().uuidString
    var title: String
    var timeRemaining: Int
    var isFavorite: Bool
    var categories: [Categorys]
    
    init(title: String, timeRemaining: Int, isFavorite: Bool, categories: [Categorys]) {
        self.title = title
        self.timeRemaining = timeRemaining
        self.isFavorite = isFavorite
        self.categories = categories
    }
}

enum CategoryCookMethod: String, Codable {
    case boiling = "끓이기"
    case baking = "굽기"
    case stirFrying = "볶기"
    case steaming = "찜"
    case frying = "튀기기"

    // 이미지 이름을 가져오는 함수
    var imageName: String {
        switch self {
        case .boiling: return "Boiling.png"
        case .baking: return "Baking.png"
        case .stirFrying: return "StirFrying.png"
        case .steaming: return "Steaming.png"
        case .frying: return "Frying.png"
        }
    }
}

/// ** 재료 관련 카테고리 **
enum Categoryingredient: String, Codable {
    case Meat = "고기"
    case Seafood = "해산물"
    case Vegetarian = "야채"
    case Grains = "쌀"
    case Eggs = "달걀"
    case Fruit = "과일"
    
    var imageName: String {
        switch self {
        case .Meat: return "Meat.png"
        case .Seafood: return "Seafood.png"
        case .Vegetarian: return "Vegetarian.png"
        case .Grains: return "Grains.png"
        case .Eggs: return "Eggs.png"
        case .Fruit: return "Fruit.png"
        }
    }
}

/// ** 음식의 목표 카테고리 **
enum CategoryFoodGoal: String, Codable {
    case Diet = "다이어트"
    case Vegetarian = "채식주의"
    case HighProtein = "고단백질"
    case QuickAndEasy = "간편 조리"
    case LowFat = "저지방"
    case BudgetFriendly = "저렴한 식사"
    
    var imageName: String {
        switch self {
        case .Diet: return "Diet.png"
        case .Vegetarian: return "Vegetarian.png"
        case .HighProtein: return "HighProtein.png"
        case .QuickAndEasy: return "QuickAndEasy.png"
        case .LowFat: return "LowFat.png"
        case .BudgetFriendly: return "BudgetFriendly.png"
        }
    }
}

/// ** 사용 기구 카테고리 **
enum CategoryUsingTool: String, Codable {
    case AirFryer = "에어프라이"
    case Oven = "오븐"
    case Microwave = "전자렌지"
    case Stove = "인덕션"
    
    var imageName: String {
        switch self {
            case .AirFryer: return "AirFryer.png"
            case .Oven: return "Oven.png"
            case .Microwave: return "Microwave.png"
            case .Stove: return "Stove.png"
        }
    }
}

enum CategoryFoodType: String, Codable {
    case korean = "한식"
    case chinese = "중식"
    case japanese = "일식"
    case western = "양식"
    case thai = "태국요리"
    case world = "세계각국요리"
    
    var imageName: String {
        switch self {
        case .korean: return "korean_food"
        case .chinese: return "chinese_food"
        case .japanese: return "japanese_food"
        case .western: return "western_food"
        case .thai: return "thai_food"
        case.world: return "world_food"
        }
    }
}



