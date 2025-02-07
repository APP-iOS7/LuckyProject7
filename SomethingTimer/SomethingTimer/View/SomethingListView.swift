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
    @Query private var categorysRecipes: [RecipesByCategory] = []
    @State private var showingAddView = false
    @State private var magnifierOffset: CGSize = .zero
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
                    if categorysRecipes.contains(where: { $0.selectedCategory == selectedCategory && !$0.somethingItems.isEmpty }) {
                        ForEach(categorysRecipes.filter { $0.selectedCategory == selectedCategory }, id: \.selectedCategory) { category in
                            ForEach(category.somethingItems, id: \.title) { item in
                                SomethingRowView(item: item)
                            }
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deleteItems)
                        .listRowSeparator(.hidden)
                    } else {
                        ZStack {
                            Spacer()
                            VStack {
                                Image("돋보기") // Assets에 저장한 돋보기 이미지 사용
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.green)
                                    .offset(magnifierOffset) // 애니메이션 적용
                                    .onAppear {
                                        startAnimation()
                                    }
                                
                                Text("레시피를 넣어주세요")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding(.top, 10)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                        }
                    }
                 
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
//                print("각 나라별 : ", selectedCategory)
//                print("recipes : ", categorysRecipes)
//                if categorysRecipes.isEmpty {
//                    modelContext.insert(RecipesByCategory(selectedCategory: .KoreanFood, somethingItems: [
//                        SomethingItem(title: "국밥", cellInfo: [
//                            CellInfo(smallTitle: "1. 물을 끓인다", content: "물이 끓을 때까지 강불에 조리한다.", timeRemaining: nil),
//                            CellInfo(smallTitle: "2. 끓인 물에 밥과 재료를 넣는다", content: "소금 1스푼\n간장 반스푼\n대파 적당히", timeRemaining: nil),
//                            CellInfo(smallTitle: "3. 계란을 넣고 3분간 더 끓인다", content: "도중에 계란이 풀리지 않게 조심한다.", timeRemaining: 3)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer),selectedImage: Data()),
//                        
//                        SomethingItem(title: "돈까스", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer),selectedImage: Data()),
//                        
//                        SomethingItem(title: "제육볶음", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer),selectedImage: Data())
//                    ]))
//                }
            }
            .sheet(isPresented: $showingAddView) {
                AddSomethingView(mainCategory: selectedCategory)
            }
        }
    }
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 1.5)) {
                magnifierOffset = CGSize(width: CGFloat.random(in: -50...50), height: CGFloat.random(in: -50...50))
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
