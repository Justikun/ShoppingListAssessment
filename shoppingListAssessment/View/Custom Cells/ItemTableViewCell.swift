//
//  ItemTableViewCell.swift
//  shoppingListAssessment
//
//  Created by Justin Lowry on 12/17/21.
//

import UIKit

protocol TaskCompletionDelegate: AnyObject {
    func didTapCheck(_ sender: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var completionIcon: UIButton!
    @IBOutlet weak var itemNameLabel: UILabel!
    

    // MARK: - Properties
    var delegate: TaskCompletionDelegate?
    var item: Item? {
        didSet {
            updateViews()
        }
    }

    // MARK: - Actions
    @IBAction func didTapCheck(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.didTapCheck(self)
    }

    // MARK: - Methods
    func updateViews() {
        guard let item = item else { return }
        itemNameLabel.text = item.name
        
        if item.isChecked {
            completionIcon.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            completionIcon.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
}
