//
//  ContentView.swift
//  SomethingTimer
//
//  Created by 김건 on 1/27/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                AnimatedTitleView() // 애니메이션 효과 적용된 타이틀 추가
                    .padding(.top, 10) // 상단 여백 조정
                GridView()
            }
            .padding(.top, 20)
            .background(Color.green.opacity(0.2))
        }
    }
    
}

// MARK: - 애니메이션 효과 적용된 타이틀 뷰
struct AnimatedTitleView: View {
    @State private var offsetValue: CGFloat = 5 // 좌우 흔들림 정도

    var body: some View {
        Text("원하는 요리의 카테고리를 선택하세요!")
            .font(.system(size: 22, weight: .semibold))
            .padding(.bottom, 5)
        
            .offset(x: offsetValue) // 좌우로 흔들리는 효과

            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                    offsetValue = -5 // 왼쪽 & 오른쪽 반복 이동
                }
            }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(PreviewContainer.shared.container)
}




// 타이머 데이터 받는 법
// 타이머 서클 원으로 하는 법
