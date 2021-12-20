//
//  ItemController.swift
//  shoppingListAssessment
//
//  Created by Justin Lowry on 12/17/21.
//

import Foundation

class ItemController {
    // MARK: - Properties
    var items: [Item] = [Item(name: "Milk"), Item(name: "Cereal"), Item(name: "Spoon")]
    static var shared = ItemController()
    
    // MARK: - Methods
    // CRUD
    // Create
    func create(name: String) {
        let newItem = Item(name: name)
        items.append(newItem)
        saveToPersistentStorage()
    }
    
    func itemIsChecked(item: Item) {
        item.isChecked = !item.isChecked
        saveToPersistentStorage()
    }
    
    // Delete
    func delete(item: Item) {
        guard let index = items.firstIndex(of: item) else { return }
        items.remove(at: index)
        saveToPersistentStorage()
    }
    
    // MARK: - Persistence
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Item.json")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage() {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: fileURL())
        } catch let e {
            print("Error Encoding")
            print(e)
            print(e.localizedDescription)
        }
    }
    
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            self.items = try JSONDecoder().decode([Item].self, from: data)
            
        } catch let e {
            print("Error Decoding")
            print(e)
            print(e.localizedDescription)
        }
    }
}
