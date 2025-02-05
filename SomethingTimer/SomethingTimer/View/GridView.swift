//
//  GridView.swift
//  SomethingTimer
//
//  Created by 김건 on 2/5/25.
//

import SwiftUI
import SwiftData

struct CategoryMainFoodList {
    static let foodCategorys: [CategoryMainFood] = [
        .KoreanFood, .ChineseFood, .JapaneseFood, .WesternFood, .SoutheastFood, .EtcFood
    ]
}

struct GridView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var somethingItems: [SomethingItem]
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(CategoryMainFoodList.foodCategorys, id: \.self) { category in
                    NavigationLink(destination: SomethingListView()) {
                        SomethingGridView(category: category)
                    }
                }
            }
            .padding(.top, 40)
            .padding()
        }
        
    }
}

struct SomethingGridView: View {
    let category: CategoryMainFood
    
    var body: some View {
        VStack {
            Image(category.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.8), lineWidth: 2)
                )
                .shadow(color: Color.gray.opacity(0.8), radius: 5, x: 2, y: 2)
            
            Text(category.rawValue)
                .font(.headline)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 8)
        }
        
        .padding()
        .frame(width: 160, height: 180)
        .background(getCategoryColor(for: category))
        .cornerRadius(15)
        .shadow(color: Color.red.opacity(0.3), radius: 5, x: 2, y: 2)
        
    }
    private func getCategoryColor(for category: CategoryMainFood) -> Color {
        switch category {
        case .KoreanFood: return Color.red.opacity(0.4)
        case .WesternFood: return Color.blue.opacity(0.4)
        case .ChineseFood: return Color.orange.opacity(0.4)
        case .JapaneseFood: return Color.purple.opacity(0.4)
        case .SoutheastFood: return Color.green.opacity(0.4)
        case .EtcFood: return Color.yellow.opacity(0.4)
        }
    }
}


#Preview {
    GridView()
        .modelContainer(PreviewContainer.shared.container)
}





