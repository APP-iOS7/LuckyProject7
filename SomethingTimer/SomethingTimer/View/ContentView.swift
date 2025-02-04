//
//  ContentView.swift
//  SomethingTimer
//
//  Created by 김건 on 1/27/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var showingAddSomething = false
    @State private var searchText = ""

    var body: some View {
        NavigationStack{
            SomethingListView(searchText: searchText)
                .searchable(text: $searchText)
                .navigationTitle("Food Timer")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: {
                            showingAddSomething = true
                        }) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
        }
        .sheet(isPresented: $showingAddSomething) {
            AddSomethingView()
        }
    }


}

#Preview {
    ContentView()
        .modelContainer(PreviewContainer.shared.container)
}



// 타이머 데이터 받는 법
// 타이머 서클 원으로 하는 법
