//
//  RecipeCellView.swift
//  SomethingTimer
//
//  Created by 정보경 on 2/5/25.
//

import SwiftUI

struct RecipeCellView: View {
    @State private var isExpanded = false
    @State private var isTimerSheetPresented = false
    @State private var hasTimer: Bool = false
    
    @State private var selectedHours: Int = 0
    @State private var selectedMinutes: Int = 0
    @State private var selectedSeconds: Int = 0
    
    @Binding var cellInfo: CellInfo
    
    let bgColor: Color = .green
    
    var body: some View {
        VStack {
            DisclosureGroup(isExpanded: $isExpanded) {
                VStack(alignment: .leading) {
                    contents()
                    timerButton()
                }
                .frame(minHeight: 150)
                .padding(.vertical, 10)
                
            } label: {
                subTitle()
            }
            .accentColor(.clear)
            .background(RoundedRectangle(cornerRadius: 8).fill(bgColor.opacity(0.1)))
            .padding()
        }
        .sheet(isPresented: $isTimerSheetPresented) {
            TimerSettingView(
                selectedHours: $selectedHours,
                selectedMinutes: $selectedMinutes,
                selectedSeconds: $selectedSeconds,
                onConfirm: {
                    // 저장 버튼 눌렀을 때 동작을 클로저로 넘겨줌
                    let totalTimeInSeconds = (selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
                    cellInfo.timeRemaining = totalTimeInSeconds
                    hasTimer = true
                    isTimerSheetPresented = false
                }
            )
        }
    }
    
    private func contents() -> some View {
        GeometryReader { geo in
            TextField("Enter steps", text: $cellInfo.content, axis: .vertical)
                .frame(width: geo.size.width, height: geo.size.height, alignment: .topLeading)
                .padding()
                .foregroundStyle(bgColor)
        }
    }
    
    private func subTitle() -> some View {
        HStack {
            TextField("소제목을 입력하세요", text: $cellInfo.smallTitle)
                .font(.headline)
                .foregroundStyle(bgColor)
                .frame(alignment: .leading)
                .multilineTextAlignment(.leading)
            Spacer()
            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                .foregroundColor(bgColor)
        }
        .padding()
    }
    
    private func timerButton() -> some View {
        Button {
            // 타이머 설정 버튼 클릭 시, 타이머 설정 화면을 띄움
            isTimerSheetPresented.toggle()
        } label: {
            Image(systemName: "timer")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundStyle(hasTimer ? .blue : .gray)
        }
        .padding(5)
    }
}

#Preview {
    RecipeCellView(cellInfo: .constant(CellInfo(smallTitle: "", content: "")))
}
