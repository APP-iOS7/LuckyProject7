//
//  AddSomethingView.swift
//  SomethingTimer
//
//  Created by 김건 on 1/27/25.
//

import SwiftUI

struct AddSomethingView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var isFavorite: Bool = false
    @State private var showAlert: Bool = false
    @State private var isTimer: Bool = false
    
    @State private var category: Categorys = Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer)
    
    // 기본 container를 하나 가집니다.
    @State private var cellInfo: [CellInfo] = [
        CellInfo(smallTitle: "", content: "", timeRemaining: nil)
    ]
    
    @State private var stepTitle: String = ""
    @State private var stepDescription: String = ""
    
    let bgColor: Color = .indigo
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    // 상단 제목 필드
                    topTextField
                    // 상단 카메라 부분
                    topImageView
                    // 중앙 listView
                    middleRecipeView
                    // 즐겨찾기 뷰
                    starView
                }
                .frame(maxHeight: .infinity)
                .navigationTitle("레시피 수정")
                .navigationBarTitleDisplayMode(.inline)
                
                saveButton
                Spacer()
            }
            .padding(.horizontal)
            .background(.green.opacity(0.2))
        }
        .alert("타이틀을 입력해주세요", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
    
    private var starView: some View {
        Section {
            HStack {
                Text("즐겨찾기")
                Spacer()
                StarToggleView(isFavorite: $isFavorite)
            }
        }
        .padding()
    }
    
    private var topTextField: some View {
        TextField("Title", text: $title)
            .frame(minHeight: 70,maxHeight: 100)
            .background(.white)
            .clipShape(.rect(cornerRadius: 12))
            .padding(.vertical)
    }
    /// ** 이미지 상단 View **
    private var topImageView: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.white)
            .frame(minHeight: 200, maxHeight: 200)
            .padding(.vertical)
    }
    /// ** 중앙 레시피 View **
    private var middleRecipeView: some View {
        VStack {
            HStack {
                Spacer()
                Button { // 카테고리 버튼
                    // action: Select category
                } label: {
                    Image(systemName: "square.grid.2x2")
                        .font(.title)
                }
                Button { // 추가 버튼
                    // action: Add CellInfoView
                    cellInfo.append(CellInfo(smallTitle: "", content: ""))
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.title)
                }
            }
            .padding([.leading, .trailing, .top])
            // 펼쳐지거나 닫히는 container
            ForEach(cellInfo.indices, id: \.self) { index in
                RecipeCellView(cellInfo: $cellInfo[index])
            }
        }
        .background(.white)
        .clipShape(.rect(cornerRadius: 12))
        .padding(.top)
    }
    
    private var saveButton: some View {
        Button("저장") {
            // 타이틀 미 입력 시 알람을 띠우도록 조정
            if title.isEmpty {
                showAlert = true
            } else {
                let something = SomethingItem(title: title, cellInfo: cellInfo, isFavorite: isFavorite, categories: category)
                modelContext.insert(something)
                dismiss()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 50)
        .font(.title3)
        .background(.white)
        .foregroundStyle(.green)
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    AddSomethingView()
}
