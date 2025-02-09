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
    var selectedCategory: CategoryMainFood
    @Query private var categorysRecipes: [RecipesByCategory]
    @State private var showingAddView = false
    @State private var recipes: [RecipesByCategory] = [] // 초기 값
    @State private var magnifierOffset: CGSize = .zero
    let searchText: String
    
    init(selectedCategory: CategoryMainFood ,searchText: String = "") {
        self.searchText = searchText
        self.selectedCategory = selectedCategory
    }
    var body: some View {
        NavigationStack {
                VStack {
                    Spacer().frame(height: 16)
                    List {
                        if categorysRecipes[categorysRecipes.firstIndex(where: {$0.selectedCategory == selectedCategory }) ?? 0].somethingItems.isEmpty {
                            // 비어있을 경우
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
                            .listRowSeparator(.hidden)
                        }
                        else {
                            // query에 조건문을 통해 배열 안에 맞는 하나의 RecipesByCategory를 가져왔습니다 ex) [RecipesByCategory]
                            ForEach(categorysRecipes[categorysRecipes.firstIndex(where: {$0.selectedCategory == selectedCategory}) ?? 0].somethingItems, id: \.self) { recipes in
                                SomethingRowView(item: recipes)
                                    .listRowSeparator(.hidden)
                            }
                        }
                    }
                    
                    .listStyle(.plain)
                    .listRowInsets(.none)
                }
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
            .sheet(isPresented: $showingAddView) {
                AddSomethingView(mainCategory: selectedCategory)
            }
            .onAppear {
                filterRecipes()
            }
            .onChange(of: categorysRecipes, initial: true) {
                filterRecipes()
            }
    }
    private func filterRecipes() {
        // selectedCategory를 기준으로 필터링
        recipes = categorysRecipes.filter { $0.selectedCategory == selectedCategory }
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
