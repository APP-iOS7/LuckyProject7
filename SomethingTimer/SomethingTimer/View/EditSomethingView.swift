//
//  EditSomethingView.swift
//  SomethingTimer
//
//  Created by 김건 on 1/27/25.
//

// commit : toolBar 제거 및 save 버튼 커스텀 View 전환
// 디자인 완성
// disclosureGroupView를 교체 해주시면 됩니다

import SwiftUI

struct EditSomethingView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let something: SomethingItem
    
    @State private var title: String
    @State private var isFavorite: Bool
    @State private var selectedHours: Int
    @State private var selectedMinutes: Int
    @State private var selectedSeconds: Int
    @State private var showAlert: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage?

    /// ** 카테고리 open / close 상태 변수
    @State private var isShowCategory: Bool = false
    // 기본 container를 하나 가집니다.
    @State private var cellInfo: [CellInfo] = [
        CellInfo(smallTitle: "", content: "", timeRemaining: nil)
    ]
    init(something: SomethingItem) {
        self.something = something
        self._title = State(initialValue: something.title)
        self._isFavorite = State(initialValue: something.isFavorite)
        self._selectedHours = State(initialValue: something.cellInfo[0].timeRemaining ?? 0 / 3600)
        self._selectedMinutes = State(initialValue: (something.cellInfo[0].timeRemaining ?? 0 % 3600) / 60)
        self._selectedSeconds = State(initialValue: something.cellInfo[0].timeRemaining ?? 0 % 60)

    }
    
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
//                    Section {
//                        HStack {
//                            Text("즐겨찾기")
//                            Spacer()
//                            StarToggleView(isFavorite: $isFavorite)
//                        }
//                    }
//                    .padding(.horizontal)
                }
                .frame(maxHeight: .infinity)
                .navigationTitle("레시피 수정")
                .navigationBarTitleDisplayMode(.inline)
                
                saveButton
                Spacer()
            }
            .padding(.horizontal)
            .background(.green.opacity(0.5))
            .sheet(isPresented: $isShowCategory) {
                ShowCategoryView(something: something)
            }
        }
        .alert("타이틀과 시간을 입력해주세요", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
    
    /// ** 상단 Title field View **
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
                Spacer()
                Image(systemName: "square.grid.2x2")
                    .font(.title)
                    .onTapGesture {
                        showCategoryBottomSheet()
                    }
                Image(systemName: "plus.circle")
                    .font(.title)
            }
            .padding([.leading, .trailing, .top])
            // 펼쳐지거나 닫히는 container
            RecipeCellView(cellInfo: $cellInfo[0])
        }
        .background(.white)
        .clipShape(.rect(cornerRadius: 12))
        .padding(.top)
    }
    ///. ** 중앙 disclosureGroupView 펼쳐지는 View
    private var disclosureGroupView: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundStyle(.red)
            .frame(maxWidth: .infinity, minHeight: 50)
            .padding()
    }
    ///** Save Button View **
    private var saveButton: some View {
        Button("저장") {

//            if title.isEmpty || selectedHours == 0 && selectedMinutes == 0 && selectedSeconds == 0 {
//                showAlert = true
//            } else {
//                something.title = title
//                something.isFavorite = isFavorite
//                something.timeRemaining = selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds
//                
//                
//                // 오류 처리 추가
//                do {
//                    try modelContext.save() // 오류가 발생할 수 있어 'try' 사용
//                    dismiss() // 저장 후 화면 닫기
//                } catch {
//                    // 오류 처리: 오류 메시지를 사용자에게 알릴 수 있습니다.
//                    print("Error saving context: \(error.localizedDescription)")
//                }
//            }

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
}

#Preview {

    EditSomethingView(something: SomethingItem(title: "", cellInfo: [CellInfo(smallTitle: "소제목", content: "주저리주저리", timeRemaining: 3600)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer)))
}

