//
//  EditSomethingView.swift
//  SomethingTimer
//
//  Created by 김건 on 1/27/25.
//

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
    
    init(something: SomethingItem) {
        self.something = something
        self._title = State(initialValue: something.title)
        self._isFavorite = State(initialValue: something.isFavorite)
        self._selectedHours = State(initialValue: something.timeRemaining / 3600)
        self._selectedMinutes = State(initialValue: (something.timeRemaining % 3600) / 60)
        self._selectedSeconds = State(initialValue: something.timeRemaining % 60)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                }
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
                Section {
                    HStack {
                        Text("즐겨찾기")
                        Spacer()
                        StarToggleView(isFavorite: $isFavorite)
                    }
                }
            }
            .navigationTitle("Edit Something")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        something.title = title
                        something.isFavorite = isFavorite
                        something.timeRemaining = selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds
                        
                        // 오류 처리 추가
                        do {
                            try modelContext.save() // 오류가 발생할 수 있어 'try' 사용
                            dismiss() // 저장 후 화면 닫기
                        } catch {
                            // 오류 처리: 오류 메시지를 사용자에게 알릴 수 있습니다.
                            print("Error saving context: \(error.localizedDescription)")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    EditSomethingView(something: SomethingItem(title: "Hello, World!!", timeRemaining: 3600, isFavorite: false))
}
