//
//  ListTableViewController.swift
//  shoppingListAssessment
//
//  Created by Justin Lowry on 12/17/21.
//

import UIKit

class ListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ItemController.shared.loadFromPersistentStorage()
    }

    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        //Show alert
        showAlert()
    }
    
    // MARK: - Methods
    func showAlert() {
        let alert = UIAlertController(title: "Add Item", message: "Add item to you shopping list", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Item"
            field.returnKeyType = .done
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
             // read text field value
            
            guard let fields = alert.textFields else { return }
            guard let item = fields[0].text else { return }
            ItemController.shared.create(name: item)
            self.tableView.reloadData()
        }))
        present(alert, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return ItemController.shared.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }
        let item = ItemController.shared.items[indexPath.row]
        cell.delegate = self
        cell.item = item
    
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = ItemController.shared.items[indexPath.row]
            ItemController.shared.delete(item: item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension ListTableViewController: TaskCompletionDelegate {
    func didTapCheck(_ sender: ItemTableViewCell) {
        guard let item = sender.item else { return }
        ItemController.shared.itemIsChecked(item: item)
        sender.updateViews()
    }
}
