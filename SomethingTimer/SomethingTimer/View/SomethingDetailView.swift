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
            VStack {
                Text(item.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 20)
                
                ProgressView(value: Double(currentIndex + 1), total: Double(item.cellInfo.count))
                    .progressViewStyle(LinearProgressViewStyle(tint: .black))
                    .frame(width: 200)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .padding(.horizontal)
            
            HStack {
  
                Button(action: {
                    if currentIndex > 0 { currentIndex -= 1 }
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                        .shadow(radius: 3)
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
                        .font(.title)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                .disabled(currentIndex == item.cellInfo.count - 1)
            }
            .padding(.horizontal)
            
            TabView(selection: $currentIndex) {
                ForEach(item.cellInfo.indices, id: \ .self) { index in
                    RecipeStepView(cellInfo: item.cellInfo[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .background(Color.green.opacity(0.2).edgesIgnoringSafeArea(.all))
        .navigationTitle(item.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("수정") {
                    showingEditView = true
                }
                .foregroundColor(.blue)
            }
        }
        .sheet(isPresented: $showingEditView) {
            EditSomethingView(something: item)
        }
    }
}

struct RecipeStepView: View {
    let cellInfo: CellInfo
    
    var body: some View {
        VStack {
            Text(cellInfo.smallTitle)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text(cellInfo.content)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .shadow(radius: 3)
                .padding()
            
            if let time = cellInfo.timeRemaining, time > 0 {
                TimerView(remainingTime: time)
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
            
            HStack {
                Button(timerRunning ? "일시정지" : "시작") {
                    if timerRunning {
                        timerRunning = false
                        timer?.invalidate()
                    } else {
                        startTimer()
                    }
                }
                .padding()
                .frame(width: 100)
                .background(timerRunning ? Color.red : Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 2)
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
    SomethingDetailView(item: SomethingItem(title: "Hello, World!!", cellInfo: [CellInfo(smallTitle: "Step 1", content: "설명", timeRemaining: 60)], isFavorite: false, categories: Categorys(categoryCookMethod: .baking, categoryIngredient: .Eggs, categoryFoodGoal: .BudgetFriendly, categoryUsingTool: .AirFryer),selectedImage: Data()))
}



