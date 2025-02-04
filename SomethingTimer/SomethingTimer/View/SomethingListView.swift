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
    
    let searchText: String
    
    init(searchText: String = "") {
        self.searchText = searchText
        
        let predicate = #Predicate<SomethingItem> { something in
            searchText.isEmpty ? true : something.title.contains(searchText) == true
        }
        
        _something = Query(filter: predicate, sort: [SortDescriptor(\SomethingItem.title)])
    }
    
    var body: some View {
        List {
            ForEach(something.sorted { $0.isFavorite && !$1.isFavorite }) { item in
                SomethingRowView(item: item)
            }
            .onDelete(perform: deleteItems)
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
