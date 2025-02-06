//
//  TimerSettingView.swift
//  SomethingTimer
//
//  Created by 정보경 on 2/6/25.
//

import SwiftUI

struct TimerSettingView: View {
    @Binding var selectedHours: Int
    @Binding var selectedMinutes: Int
    @Binding var selectedSeconds: Int
    
    var onConfirm: () -> Void
    
    var body: some View {
        VStack {
            Text("타이머 설정")
                .font(.headline)
                .padding()
            
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
            .padding()

            Button(action: onConfirm) {
                Text("확인")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
}

#Preview{
    TimerSettingView(selectedHours: .constant(0), selectedMinutes: .constant(0), selectedSeconds: .constant(0)) {}
}
