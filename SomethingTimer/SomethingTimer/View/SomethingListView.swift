//
//  SomethingListView.swift
//  SomethingTimer
//
//  Created by 김건 on 1/27/25.
//

import SwiftUI
import SwiftData

struct SomethingListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var something: [SomethingItem]
    
    
    @State private var showingAddView = false
    
    let searchText: String
    
    init(searchText: String = "") {
        self.searchText = searchText
        
        let predicate = #Predicate<SomethingItem> { something in
            searchText.isEmpty ? true : something.title.contains(searchText) == true
        }
        
        _something = Query(filter: predicate, sort: [SortDescriptor(\SomethingItem.title)])
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 16)
                
                List {
                    ForEach(something.sorted { $0.isFavorite && !$1.isFavorite }) { item in
                        SomethingRowView(item: item)
                    }
                    .onDelete(perform: deleteItems)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .navigationTitle("레시피 목록")
            .font(.headline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddView = true
                    }) {
                        Text("더하기")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddSomethingView()
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(something[index])
            }
            
            // 모델 컨텍스트 저장 후 삭제 사항 반영
            do {
                try modelContext.save()
            } catch {
                print("Error saving context after delete: \(error.localizedDescription)")
            }
        }
    }
}


#Preview {
    SomethingListView()
        .modelContainer(PreviewContainer.shared.container)
}
