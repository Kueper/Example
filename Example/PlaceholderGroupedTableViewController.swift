//
//  PlaceholderGroupedTableViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-06.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class PlaceholderGroupedTableViewController: PlaceholderViewController {
    
    internal var tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["tableView"] = tableView
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        self.tableView.backgroundColor = Colour.lightGrey
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.estimatedRowHeight = CGFloat(60)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = Colour.lightGrey
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.matchSuper(tableView)
        _constraints.activate()
    }
}

extension PlaceholderGroupedTableViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as! TableViewCell
        return cell
    }
}

extension PlaceholderGroupedTableViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

