//
//  Array+Only.swift
//  Memorize
//
//  Created by Alexandre Estevam on 06/04/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
