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
    @State private var descriptions: [String] = []
    
    @State private var selectedHours: Int = 0
    @State private var selectedMinutes: Int = 0
    @State private var selectedSeconds: Int = 0
    
    @State private var showAlert: Bool = false
    @State private var isTimer: Bool = false
    
    
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
                    
                    //Section {
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
            .background(.green.opacity(0.2))
        }
        .alert("타이틀을 입력해주세요", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
        //        NavigationStack {
        //            Form {
        //                Section {
        //                    TextField("Title", text: $title)
        //                }
        //                Section(header: Text("조리 단계").font(.headline)) {
        //                    HStack() {
        //                        Spacer()
        //                        Button {
        //
        //                        } label: {
        //                            Image(systemName: "plus")
        //                                .foregroundStyle(bgColor)
        //                        }
        //                    }
        ////                    RecipeCellView()
        ////                    ForEach(descriptions.indices, id: \.self) { index in
        ////                        TextField("레시피를 작성하세요", text: $descriptions[index])
        ////                    }
        //                }
        //                Section {
        //                    HStack {
        //                        Text("즐겨찾기")
        //                        Spacer()
        //                        StarToggleView(isFavorite: $isFavorite)
        //                    }
        //                }
        //            }
        //            .navigationTitle("New Recipe")
        //            .toolbar {
        //                ToolbarItem(placement: .navigationBarLeading) {
        //                    Button("Cancel") {
        //                        dismiss()
        //                    }
        //                }
        //                ToolbarItem(placement: .navigationBarTrailing) {
        //                    Button("Save") {
        //                        if title.isEmpty || selectedHours == 0 && selectedMinutes == 0 && selectedSeconds == 0 {
        //                            showAlert = true
        //                        } else {
        //                            let totalTime = selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds
        //                            let somthing = SomethingItem(title: title, timeRemaining: totalTime, isFavorite: isFavorite, categories: [])
        //                            modelContext.insert(somthing)
        //                            dismiss()
        //                        }
        //                    }
        //                }
        //            }
        //            .alert("타이틀과 시간을 입력해주세요", isPresented: $showAlert) {
        //                Button("OK", role: .cancel) {}
        //            }
        //        }
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
                Image(systemName: "square.grid.2x2")
                    .font(.title)
                Image(systemName: "plus.circle")
                    .font(.title)
            }
            .padding([.leading, .trailing, .top])
            // 펼쳐지거나 닫히는 container
            // 기본 container를 하나 가집니다.
            RecipeCellView(stepTitle: $stepTitle, stepDescription: $stepDescription)
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
                let totalTime = selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds
                let somthing = SomethingItem(title: title, timeRemaining: totalTime, isFavorite: isFavorite, categories: [])
                modelContext.insert(somthing)
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

//    func timerView() -> some View {
//        HStack {
//            Picker("시", selection: $selectedHours) {
//                ForEach(0..<24, id: \.self) { hour in
//                    Text("\(hour) hour")
//                }
//            }
//
//            Picker("분", selection: $selectedMinutes) {
//                ForEach(0..<60, id: \.self) { minute in
//                    Text("\(minute) min")
//                }
//            }
//
//            .frame(width: 100)
//
//            Picker("초", selection: $selectedSeconds) {
//                ForEach(0..<60, id: \.self) { second in
//                    Text("\(second) sec")
//                }
//            }
//            .frame(width: 100)
//        }
//    }
