//
//  SomethingDetailView.swift
//  SomethingTimer
//
//  Created by 김건 on 1/27/25.
//

import SwiftUI
import SwiftData
import AVFoundation

struct SomethingDetailView: View {
    
    let item: SomethingItem
    @State private var currentIndex: Int = 0
    @State private var showingEditView: Bool = false
    
    var body: some View {
        VStack {
            Text(item.title)
                .font(.largeTitle)
                .padding()
            
            HStack {
                Button(action: {
                    if currentIndex > 0 { currentIndex -= 1 }
                }) {
                    Image(systemName: "chevron.left")
                        .font(.largeTitle)
                        .foregroundColor(currentIndex > 0 ? .blue : .gray)
                }
                .disabled(currentIndex == 0)
                
                Spacer()
                
                Text("Step \(currentIndex + 1) / \(item.cellInfo.count)")
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    if currentIndex < item.cellInfo.count - 1 { currentIndex += 1 }
                }) {
                    Image(systemName: "chevron.right")
                        .font(.largeTitle)
                        .foregroundColor(currentIndex < item.cellInfo.count - 1 ? .blue : .gray)
                }
                .disabled(currentIndex == item.cellInfo.count - 1) // 마지막 단계에서는 버튼 비활성화
            }
            .padding()
            
            TabView(selection: $currentIndex) {
                ForEach(item.cellInfo.indices, id: \.self) { index in
                    RecipeStepView(cellInfo: item.cellInfo[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .background(Color(red: 0.85, green: 1.0, blue: 0.85).edgesIgnoringSafeArea(.all))
        .navigationTitle(item.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("수정과") {
                    showingEditView = true
                }
            }
        }
        .sheet(isPresented: $showingEditView) {
            EditSomethingView(something: item)
        }
        .font(.headline)
        .foregroundColor(.white)
        .shadow(radius: 3)
    }
}

struct RecipeStepView: View {
    let cellInfo: CellInfo
    
    var body: some View {
        VStack {
            Text(cellInfo.smallTitle)
                .font(.title)
                .padding()
            
            Text(cellInfo.content)
                .padding()
            
            if let time = cellInfo.timeRemaining, time > 0 {
                TimerView(remainingTime: time) // 타이머 추가
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding()
    }
}

struct TimerView: View {
    @State var remainingTime: Int
    @State private var timerRunning: Bool = false
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            Text("남은 시간: \(formatTime(remainingTime))")
                .font(.title2)
                .padding()
            
            if timerRunning {
                Button("일시정지") {
                    timerRunning = false
                    timer?.invalidate()
                }
            } else {
                Button(timer == nil ? "시작" : "재개") {
                    startTimer()
                }
            }
            
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func startTimer() {
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer.invalidate()
                self.timer = nil
                timerRunning = false
                try! SoundManager.shared.playSound(fileName: "cookEndSound", type: "mp3")
                SoundManager.shared.play()
            }
        }
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {

    SomethingDetailView(item: SomethingItem(title: "Hello, World!!", cellInfo: [CellInfo(smallTitle: "Step 1", content: "설명", timeRemaining: 60)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer)))

}


