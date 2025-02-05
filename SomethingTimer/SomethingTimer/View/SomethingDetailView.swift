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
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var timeRemaining: Int
    @State private var isRunning: Bool = false
    @State private var showingEditView: Bool = false
    
    var item: SomethingItem
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var progress: CGFloat {
        guard timeRemaining > 0 else { return 0 }
        return CGFloat(timeRemaining) / CGFloat(item.timeRemaining)
    }
    
    init(item: SomethingItem) {
        self.item = item
        _timeRemaining = State(initialValue: item.timeRemaining)  // 초기화 추가
    }
    
    var body: some View {
        NavigationStack {
            Text("\(item.title)")
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.gray.opacity(0.2)) // 배경 원
                Circle()
                    .trim(from: 0, to: progress) // 시간에 따른 채워지는 부분
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .foregroundColor(.blue) // 진행 상태 색상
                    .rotationEffect(.degrees(-90)) // 0도가 상단이 되도록 회전
                    .animation(.easeInOut(duration: 0.5), value: progress) // 애니메이션
            }
            .frame(width: 200, height: 200)
            .padding()
            
            VStack {
                Text("\(String(format: "%02d", timeRemaining / 3600)):\(String(format: "%02d", (timeRemaining % 3600) / 60)):\(String(format: "%02d", timeRemaining % 60))")
                    .font(.system(size: 30, weight: .bold))
                    .padding()
            }
            
            HStack {
                // 재생 / 일시 정지 버튼
                Button(action: {
                    if !isRunning {
                        // 타이머를 시작하기 전에 시간 설정을 반영
                        timeRemaining = item.timeRemaining
                    }
                    isRunning.toggle()
                }, label: {
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .padding()
                })
                
                // 리셋 버튼
                Button(action: {
                    isRunning = false
                    timeRemaining = item.timeRemaining // 초기화시 아이템의 timeRemaining 값 사용
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .padding()
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Delete") {
                        modelContext.delete(item)
                        // 오류 처리 추가
                        do {
                            try modelContext.save() // 오류가 발생할 수 있어 'try' 사용
                            dismiss() // 삭제 후 화면 닫기
                        } catch {
                            // 오류 처리: 오류 메시지를 사용자에게 알릴 수 있습니다.
                            print("Error deleting item: \(error.localizedDescription)")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        showingEditView = true
                    }
                }
            }
        }
        .navigationTitle(item.title)
        .sheet(isPresented: $showingEditView) {
            EditSomethingView(something: item) // timeRemaining만 전달
        }
        .onReceive(timer) { _ in
            if isRunning && timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: timeRemaining, initial: true) {
            // 타이머가 0이 되면 소리만 울리도록
            if timeRemaining == 0 {
                try! SoundManager.shared.playSound(fileName: "cookEndSound", type: "mp3") // player에 AVAudioPlayer를 넣습니다
                SoundManager.shared.play() // 시작
                isRunning = false
            }
        }
    }
}

#Preview {
    SomethingDetailView(item: SomethingItem(title: "Hello, World!!", timeRemaining: 3600, isFavorite: false, categories: []))
}
