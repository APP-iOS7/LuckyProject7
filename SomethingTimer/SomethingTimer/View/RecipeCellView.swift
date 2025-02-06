//
//  RecipeCellView.swift
//  SomethingTimer
//
//  Created by 정보경 on 2/5/25.
//

import SwiftUI

struct RecipeCellView: View {
    
    @State private var isExpanded = false
    @State private var hasTimer: Bool = false
    
    // Binding으로 CellInfo 인스턴스를 받습니다.
    /* 사용자가 타이머를 설정했을 때,
     * hasTimer = true, 타이머 버튼이 활성화됩니다.
     * 타이머 설정 뷰를 띄웁니다. (현준님 뷰를 사용해도 좋을 것 같아요)
     * 시간을 계산해서 cellInfo.timeRemaining에 저장해야합니다.
     */
    @Binding var cellInfo: CellInfo
       
    let bgColor: Color = .green
    
    var body: some View {
        VStack {
            DisclosureGroup(isExpanded: $isExpanded) {
                VStack(alignment: .leading) {
                    GeometryReader { geo in
                        TextField("Enter steps", text: $cellInfo.content, axis: .vertical)
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .topLeading)
                            .padding()
                            .foregroundStyle(bgColor)
                    }
                    //.border(.black)
                    Button {
                        hasTimer.toggle()
                    } label: {
                        Image(systemName: "timer")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(hasTimer ? .blue : .gray)
                        
                    }
                    .padding(5)
                    
                }
                .frame(minHeight: 150)
                .padding(.vertical, 10)
            
            } label: {
                HStack {
                    TextField("조리 단계를 입력하세요", text: $cellInfo.smallTitle)
                        .font(.headline)
                        .foregroundStyle(bgColor)
                        .frame(alignment: .leading)
                        .multilineTextAlignment(.leading)
//                        .border(.black)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(bgColor)
                }
                .padding()
            }
            .accentColor(.clear)
            .background(RoundedRectangle(cornerRadius: 8).fill(bgColor.opacity(0.1)))
            .padding()
        }
    }
}

#Preview {
    RecipeCellView(cellInfo: .constant(CellInfo(smallTitle: "", content: "")))
}
