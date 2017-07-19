//
//  MainTableViewController.swift
//  RxViewController
//
//  Created by chenyong on 2017/7/18.
//  Copyright © 2017年 chenyong. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    var todos: [String] = []
    enum Section: Int {
        case input = 0, todos, max
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TodoStore.shared.getToDoItems { (data) in
            self.todos += data
            self.title = "TODO = (\(self.todos.count))"
            self.tableView.reloadData()
        }
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        let inputIndexPath = IndexPath(row: 0, section: Section.input.rawValue)
        guard let inputCell = tableView.cellForRow(at: inputIndexPath) as? InputTableViewCell, let text = inputCell.textField.text else {
            return
        }
        todos.insert(text, at: 0)
        inputCell.textField.text = ""
        title = "TODO - (\(todos.count))"
        tableView.reloadData()
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == Section.todos.rawValue else {
            return
        }
        todos.remove(at: indexPath.row)
        title = "TODO - (\(todos.count))"
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.max.rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError()
        }
        switch section {
        case .input: return 1
        case .todos: return todos.count
        case .max: fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError()
        }
        let todoCellResueId = "todoCellResueId"
        let inputCellResueId = "inputCellResueId"
        switch section {
        case .input:
            let cell = tableView.dequeueReusableCell(withIdentifier: inputCellResueId, for: indexPath) as! InputTableViewCell
            cell.delegate? = self
            return cell
        case .todos:
            let cell = tableView.dequeueReusableCell(withIdentifier: todoCellResueId, for: indexPath)
            cell.textLabel?.text = todos[indexPath.row]
            return cell
        case .max:
            fatalError()
        }
    }
}

//MARK InputTableViewInputCellDelegate
extension MainTableViewController: InputTableViewInputCellDelegate {
    func inputChanged(cell: InputTableViewCell, text: String) {
        let isItemLengthEnough = text.characters.count >= 3
        navigationItem.rightBarButtonItem?.isEnabled = isItemLengthEnough
    }
}












