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
    
    // 우선은 binding으로 값을 받아오도록 했습니다. 이대로 사용하려면 상위 뷰에서 state 변수를 가져야 합니다.
    @Binding var stepTitle: String
    @Binding var stepDescription: String
   
    let bgColor: Color = .green
    
    var body: some View {
        VStack {
            DisclosureGroup(isExpanded: $isExpanded) {
                ScrollView {
                    VStack(alignment: .leading) {
                        TextField("Enter steps", text: $stepDescription)
                            .frame(width: 300, height: 150, alignment: .topLeading)
                            .padding()
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
                    .padding()
                    .padding(.vertical, 10)
                }
            } label: {
                HStack {
                    TextField("조리 단계를 입력하세요", text: $stepTitle)
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
    RecipeCellView(stepTitle: .constant(""), stepDescription: .constant(""))
}
