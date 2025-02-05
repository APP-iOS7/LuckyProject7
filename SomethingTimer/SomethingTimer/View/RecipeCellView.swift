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
    @State private var description: String = ""
    
    var body: some View {
        VStack {
            DisclosureGroup(isExpanded: $isExpanded) {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        TextField("Enter steps", text: $description)
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
                    Text("제목")
                        .font(.headline)
                        .foregroundStyle(.indigo)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.indigo)
                }
                .padding()
            }
            .accentColor(.clear)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.indigo.opacity(0.1)))
            .padding()
        }
    }
}

#Preview {
    RecipeCellView()
}
