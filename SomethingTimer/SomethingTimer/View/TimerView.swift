//
//  TimerView.swift
//  SomethingTimer
//
//  Created by HJ H on 2/5/25.
//

import SwiftUI

struct TimerView: View {
    @State private var inputMinutes: String = "1"
    @State private var inputSeconds: String = "0"
    @State private var remainingTime: TimeInterval = 60
    @State private var timerRunning = false
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("⏳ Timer: \(Int(remainingTime)) sec")
                .font(.largeTitle)
                .padding()
            
            HStack {
                TextField("Minutes", text: $inputMinutes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                    .onChange(of: inputMinutes) { _ in updateRemainingTime() }
                
                Text(":" )
                    .font(.largeTitle)
                
                TextField("Seconds", text: $inputSeconds)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                    .onChange(of: inputSeconds) { _ in updateRemainingTime() }
            }
            
            HStack {
                Button(action: startTimer) {
                    Text("Start")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(timerRunning || remainingTime <= 0)
                
                Button(action: pauseTimer) {
                    Text("Pause")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .disabled(!timerRunning)
                
                Button(action: resetTimer) {
                    Text("Reset")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
    
    func updateRemainingTime() {
        let minutes = TimeInterval(inputMinutes) ?? 0
        let seconds = TimeInterval(inputSeconds) ?? 0
        remainingTime = (minutes * 60) + seconds
    }
    
    func startTimer() {
        if remainingTime > 0 {
            timerRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if remainingTime > 0 {
                    remainingTime -= 1
                } else {
                    timer?.invalidate()
                    timerRunning = false
                }
            }
        }
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timerRunning = false
    }
    
    func resetTimer() {
        timer?.invalidate()
        timerRunning = false
        updateRemainingTime()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
#Preview {
    TimerView()
}
