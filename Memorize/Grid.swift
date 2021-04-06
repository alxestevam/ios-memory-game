//
//  Grid.swift
//  Memorize
//
//  Created by Alexandre Estevam on 06/04/21.
//

import SwiftUI

struct Grid<Item, Content>: View where Item: Identifiable, Content: View {
    var items: [Item]
    var showContent: (_ data: Item) -> Content
    
    init (_ items: [Item], showContent: @escaping (_ data: Item) -> Content) {
        self.items = items
        self.showContent = showContent
    }
    
    var body: some View {
        GeometryReader() { geometry in
            ForEach(items) { item in
                body(for: item, in: GridLayout(itemCount: items.count, in: geometry.size))
            }
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        Group() {
            if let index = items.firstIndex(of: item) {
                showContent(item)
                    .frame(
                        width: layout.itemSize.width,
                        height: layout.itemSize.height
                    )
                    .position(layout.location(ofItemAt: index))
            }
        }
    }
}
