//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Alexandre Estevam on 06/04/21.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(of item: Element) -> Int? {
        return self.firstIndex(where: { element in
            element.id == item.id
        })
    }
}
