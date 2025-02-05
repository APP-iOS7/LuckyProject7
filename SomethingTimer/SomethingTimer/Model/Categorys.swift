//
//  Categorys.swift
//  SomethingTimer
//
//  Created by 김용해 on 2/5/25.
//

/// **조리 방법**
/// 사용방법 ex)
/// let cookMethod = CategoryCookMethod.boiling
/// cookMethod.rawValue // 끓이기
/// cookMethod.imageName // 이미지 이름
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
    case Rice = "쌀"
    case Eggs = "달걀"
    case Fruit = "과일"
    
    var imageName: String {
        switch self {
        case .Meat: return "Meat.png"
        case .Seafood: return "Seafood.png"
        case .Vegetarian: return "Vegetarian.png"
        case .Rice: return "Rice.png"
        case .Eggs: return "Eggs.png"
        case .Fruit: return "Fruit.png"
        }
    }
}

/// ** 음식의 목표 카테고리 **
enum CategoryFoodGoal: String, Codable {
    case Diet = "다이어트"
    case NoMeat = "채식주의"
    case HighProtein = "고단백질"
    case QuickAndEasy = "간편 조리"
    case LowFat = "저지방"
    case BudgetFriendly = "저렴한 식사"
    
    var imageName: String {
        switch self {
        case .Diet: return "Diet.png"
        case .NoMeat: return "NoMeat.png"
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

// ** ContentView 전에 CategoryView
enum CategoryMainFood: String, Codable {
    case KoreanFood = "한식"
    case WesternFood = "양식"
    case ChineseFood = "중식"
    case JapaneseFood = "한국음식"
    case SoutheastFood = "동남아 음식"
    case EtcFood = "기타음식"
    
    var imageName: String {
        switch self {
            case .KoreanFood: return "KoreanFood.png"
            case .WesternFood: return "WesternFood.png"
            case .ChineseFood: return "ChineseFood.png"
            case .JapaneseFood: return "JapaneseFood.png"
            case .SoutheastFood: return "SoutheastFood.png"
            case .EtcFood: return "EtcFood.png"
        }
    }
}

/// 카테코리는 총 4개
/// 1. 조리방법
/// 2. 재료
/// 3. 목표
/// 4. 도구
struct Categorys: Codable {
    var categoryCookMethod: CategoryCookMethod
    var categoryIngredient: Categoryingredient
    var categoryFoodGoal: CategoryFoodGoal
    var categoryUsingTool: CategoryUsingTool
    var categoryMainFood: CategoryMainFood // 메인에 나올 카테고리
}
