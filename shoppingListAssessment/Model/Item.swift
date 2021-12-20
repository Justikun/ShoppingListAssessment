//
//  Item.swift
//  shoppingListAssessment
//
//  Created by Justin Lowry on 12/17/21.
//

import Foundation

class Item: Codable {
    let name: String
    var isChecked: Bool
    
    init(name: String) {
        self.name = name
        self.isChecked = false
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
    }
}
