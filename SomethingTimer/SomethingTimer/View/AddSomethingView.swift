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
    @State private var selectedHours: Int = 0
    @State private var selectedMinutes: Int = 0
    @State private var selectedSeconds: Int = 0
    @State private var isFavorite: Bool = false
    @State private var descriptions: [String] = []
    
    @State private var showAlert: Bool = false
    @State private var showActionSheet = false
    @State private var isTimer: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                }
                Section(header: Text("조리 단계").font(.headline)) {
                    ForEach(descriptions.indices, id: \.self) { index in
                        TextField("레시피를 작성하세요", text: $descriptions[index])
                    }
                    Button {
                        showActionSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    if isTimer {
                        timerView(selectedHours: $selectedHours, selectedMinutes: $selectedMinutes, selectedSeconds: $selectedSeconds)
                    }
                }
                Section {
                    HStack {
                        Text("즐겨찾기")
                        Spacer()
                        StarToggleView(isFavorite: $isFavorite)
                    }
                }
            }
            .navigationTitle("New Recipe")
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("선택하세요"),
                    buttons: [
                        .default(Text("텍스트")) {
                            descriptions.append("")
                        },
                        .default(Text("타이머")) {
                            isTimer = true
                        },
                        .cancel()
                    ]
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if title.isEmpty || selectedHours == 0 && selectedMinutes == 0 && selectedSeconds == 0 {
                            showAlert = true
                        } else {
                            let totalTime = selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds
                            let somthing = SomethingItem(title: title, timeRemaining: totalTime, isFavorite: isFavorite, categories: [])
                            modelContext.insert(somthing)
                            dismiss()
                        }
                    }
                }
            }
            .alert("타이틀과 시간을 입력해주세요", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
    
    func timerView(selectedHours: Binding<Int>, selectedMinutes: Binding<Int>, selectedSeconds: Binding<Int>) -> some View {
        
        HStack {
            Picker("시", selection: $selectedHours) {
                ForEach(0..<24, id: \.self) { hour in
                    Text("\(hour) hour")
                }
            }
            
            Picker("분", selection: $selectedMinutes) {
                ForEach(0..<60, id: \.self) { minute in
                    Text("\(minute) min")
                }
            }
            
            .frame(width: 100)
            
            Picker("초", selection: $selectedSeconds) {
                ForEach(0..<60, id: \.self) { second in
                    Text("\(second) sec")
                }
            }
            .frame(width: 100)
        }
    }
}

#Preview {
    AddSomethingView()
}
