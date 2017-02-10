//
//  SelectionTableViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-28.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class SelectionTableViewController: PlaceholderTableViewController {
    
    var allowsMultipleSelection: Bool = false { didSet { self.tableView.allowsMultipleSelection = self.allowsMultipleSelection }}
    
    var elements: [(name: String, object: AnyObject)] = [] { didSet { self.tableView.reloadData() }}
    var selectedElements: [AnyObject] = []
    var selectionReturn: (([AnyObject]) -> Void)?
    
    override internal func setupViews() {
        super.setupViews()
        
        tableView.register(SelectionTableViewCell.self, forCellReuseIdentifier: SelectionTableViewCell.identifier)
    }
    
    override internal func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectionReturn?(selectedElements)
    }
    
    override internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTableViewCell.identifier) as! SelectionTableViewCell
        cell.majorLabel.text = elements[indexPath.row].name
        cell.selectionStyle = .none
        cell.isSelected = false
        
        let element = elements[indexPath.row].object
        
        if selectedElements.contains(where: { $0 === element }) == true {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            cell.isSelected = true
        }
        
        return cell
    }
    
    override internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if allowsMultipleSelection == false {
            // this is their selection
            selectedElements = [elements[indexPath.row].object]
            self.dismiss(animated: true, completion: nil)
        } else {
            
            let element = elements[indexPath.row].object
            
            // check if already contained
            // only comparing memory address here so be careful
            if selectedElements.contains(where: { $0 === element }) == false {
                selectedElements.append(element)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    override internal func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if selectedElements.indices.contains(indexPath.row) {
            selectedElements.remove(at: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }

    }
}
