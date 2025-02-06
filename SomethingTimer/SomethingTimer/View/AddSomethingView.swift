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
    
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage? // 해당 값은 생성된 사진을 받아와야 함.
    
    @State private var isShowCategory: Bool = false
    @State private var showAlert: Bool = false
    
    @State private var categories: Categorys = Categorys(categoryCookMethod: nil, categoryIngredient: nil, categoryFoodGoal: nil, categoryUsingTool: nil)
    
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
                .navigationTitle("레시피 생성")
                .navigationBarTitleDisplayMode(.inline)
                
                saveButton
                Spacer()
            }
            .padding(.horizontal)
            .background(.green.opacity(0.5))
            .sheet(isPresented: $isShowCategory) {
                ShowCategoryView(categories: $categories)
            }
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
        TextField("레시피의 제목을 입력하세요", text: $title)
            .frame(minHeight: 70,maxHeight: 100)
            .background(.white)
            .clipShape(.rect(cornerRadius: 12))
            .padding(.vertical)
    }
    /// ** 이미지 상단 View **
    private var topImageView: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke (
                Color.white,
                style: StrokeStyle(
                    lineWidth: 5,
                    lineCap: .round,
                    lineJoin: .round,
                    dash: [4 , 8]
                )
            )
            .foregroundStyle(.bar)
            .frame(minHeight: 200, maxHeight: 200)
            .padding(.vertical)
            .overlay {
                Circle()
                    .foregroundStyle(.white)
                    .frame(height: 150)
                    .overlay {
                        selectedImage != nil ?
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(.circle)
                            : Image(systemName: "photo.artframe.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(.circle)
                    }
            }
            .onTapGesture {
                showImagePicker.toggle()
            }
            .sheet(isPresented: $showImagePicker) { // 사진 열기
                ImagePicker(image: $selectedImage)
            }
    }
    /// ** 중앙 레시피 View **
    private var middleRecipeView: some View {
        VStack {
            HStack {
                showCategory()
                Spacer()
                Button { // 카테고리 버튼
                    // action: Select category
                    isShowCategory = true
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
                let something = SomethingItem(title: title, cellInfo: cellInfo, isFavorite: isFavorite, categories: categories ,selectedImage: Data())
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
    
    /// ** Category 목록 보여주는 부분 **
    private func showCategoryBottomSheet() {
        isShowCategory = true // true -> 카테고리 시트 열림
    }
    
    private func imageView(imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .frame(width: 40, height: 40)
    }
    
    private func showCategory() -> some View {
        HStack {
            if let imageName = categories.categoryIngredient?.imageName {
                imageView(imageName: imageName)
            }
            if let imageName = categories.categoryFoodGoal?.imageName {
                imageView(imageName: imageName)
            }
            if let imageName = categories.categoryUsingTool?.imageName {
                imageView(imageName: imageName)
            }
            if let imageName = categories.categoryCookMethod?.imageName {
                imageView(imageName: imageName)
            }
        }
    }
}

#Preview {
    AddSomethingView()
}
