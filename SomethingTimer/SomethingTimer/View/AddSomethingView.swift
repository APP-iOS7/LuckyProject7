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
            .navigationTitle("New Something")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let totalTime = selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds
                        let somthing = SomethingItem(title: title, timeRemaining: totalTime, isFavorite: isFavorite)
                        modelContext.insert(somthing)
                        dismiss()
                    }
                }
            }
            
        }
    }
}

#Preview {
    AddSomethingView()
}
