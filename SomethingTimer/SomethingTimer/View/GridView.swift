//
//  GridView.swift
//  SomethingTimer
//
//  Created by 김건 on 2/5/25.
//

import SwiftUI
import SwiftData

struct GridView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var something: [SomethingItem]
    

    
    let searchText: String
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(searchText: String = "") {
        self.searchText = searchText
        _something = Query(filter: searchText.isEmpty ? nil : #Predicate<SomethingItem> { $0.title.contains(searchText) })
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(something.sorted { $0.isFavorite && !$1.isFavorite }) { item in
                    NavigationLink(destination: SomethingListView(searchText: searchText)) {
                        SomethingGridView(item: item)
                    }
                }
            }
            .padding(.top, 40)
            .padding()
        }
    }
}

struct SomethingGridView: View {
    let item: SomethingItem
    
    var body: some View {
        VStack {
      
            Image(systemName: "arrow.clockwise")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Rectangle())
                .cornerRadius(15)
            
            Text(item.title)
                .font(.headline)
                .padding(.top, 8)
            
        }
        .padding()
        .frame(width: 160, height: 160)
        .background(Color.yellow.opacity(0.3))
        .cornerRadius(15)
        .shadow(radius: 8)
    }
}

#Preview {
    GridView()
        .modelContainer(PreviewContainer.shared.container)
}



