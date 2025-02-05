//
//  GridView.swift
//  SomethingTimer
//
//  Created by 김건 on 2/5/25.
//

import SwiftUI
import SwiftData

struct GridView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var somethingItems: [SomethingItem]
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    private let mainCategorys:[CategoryMainFood] = [.KoreanFood, .ChineseFood, .EtcFood, .JapaneseFood, .SoutheastFood, .WesternFood]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(mainCategorys, id: \.self) { category in
                    NavigationLink(destination: SomethingListView()) {
                        SomethingGridView(category: category)
                    }
                }
            }
            .padding(.top, 40)
            .padding()
        }
        .background(Color.white.opacity(0.4))
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
        .background(Color.green.opacity(0.4)) // getCategoryColor(for: item.categories.first?.categoryMainFood) 적용 시 변경
        .cornerRadius(15)
        .shadow(color: Color.red.opacity(0.3), radius: 5, x: 2, y: 2)
        
    }
    //    private func getCategoryColor(for category: CategoryMainFood?) -> Color {
    //        switch category {
    //        case .KoreanFood: return Color.red.opacity(0.2)
    //        case .WesternFood: return Color.blue.opacity(0.2)
    //        case .ChineseFood: return Color.orange.opacity(0.2)
    //        case .JapaneseFood: return Color.purple.opacity(0.2)
    //        case .SoutheastFood: return Color.green.opacity(0.2)
    //        case .EtcFood: return Color.yellow.opacity(0.2)
    //        default: return Color.gray.opacity(0.2)
    //        }
    //    }
}


#Preview {
    GridView()
        .modelContainer(PreviewContainer.shared.container)
}





