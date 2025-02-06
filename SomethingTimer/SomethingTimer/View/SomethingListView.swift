//
//  SomethingListView.swift
//  SomethingTimer
//
//  Created by 김건 on 1/27/25.
//

import SwiftUI
import SwiftData

struct SomethingListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var categorysRecipes: [RecipesByCategory]
    @State private var showingAddView = false
    let searchText: String
    var selectedCategory: CategoryMainFood
    
    init(selectedCategory: CategoryMainFood ,searchText: String = "") {
        self.searchText = searchText
        self.selectedCategory = selectedCategory
//
//        let predicate = #Predicate<SomethingItem> { something in
//            searchText.isEmpty ? true : something.title.contains(searchText) == true
//        }
//        
//        _something = Query(filter: predicate, sort: [SortDescriptor(\SomethingItem.title)])
    }
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 16)
                List {
                    ForEach(categorysRecipes.filter { $0.selectedCategory == selectedCategory }, id: \.selectedCategory) { category in
                        // SomethingItem만 순회하기 위해 category.somethingItems를 ForEach로 순회
                        ForEach(category.somethingItems, id: \.title) { item in
                            SomethingRowView(item: item)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: deleteItems)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .navigationTitle("레시피 목록")
            .font(.headline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddView = true
                    }) {
                        Text("더하기")
                            .font(.title2)
                    }
                }
            }
            .onAppear {
                print("각 나라별 : ", selectedCategory)
                print("recipes : ", categorysRecipes)
            }
            .sheet(isPresented: $showingAddView) {
                AddSomethingView()
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
//            for index in offsets {
//                modelContext.delete(something[index])
//            }
            
            // 모델 컨텍스트 저장 후 삭제 사항 반영
            do {
                try modelContext.save()
            } catch {
                print("Error saving context after delete: \(error.localizedDescription)")
            }
        }
    }
}


#Preview {
    SomethingListView(selectedCategory: .KoreanFood)
        .modelContainer(PreviewContainer.shared.container)
}
