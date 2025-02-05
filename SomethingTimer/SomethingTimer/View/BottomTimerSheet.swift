//
//  BottomTimerSheet.swift
//  SomethingTimer
//
//  Created by 김용해 on 2/5/25.
//
// 용해 : timer를 바텀 시트에 놓기 위해 분리 했습니다.
import SwiftUI

struct BottomTimerSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedHours: Int
    @State private var selectedMinutes: Int
    @State private var selectedSeconds: Int
    
    let timeRemaining: Int
    
    init(timeRemaining: Int) {
        self.timeRemaining = timeRemaining
        self._selectedHours = State(initialValue: timeRemaining / 3600)
        self._selectedMinutes = State(initialValue: (timeRemaining % 3600) / 60)
        self._selectedSeconds = State(initialValue: timeRemaining % 60)
    }
    
    var body: some View {
        NavigationStack {
            Form {
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
            .navigationTitle("타이머 바텀 시트")
            .toolbar {
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
    BottomTimerSheet(
        timeRemaining: 3600
    )
}
