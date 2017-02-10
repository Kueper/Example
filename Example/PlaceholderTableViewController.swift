//
//  PlaceholderTableViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-14.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

class PlaceholderTableViewController: PlaceholderViewController {

    internal var tableView = UITableView()
    
    override internal func setupViews() {
        super.setupViews()
        
        _views["tableView"] = tableView
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.estimatedRowHeight = CGFloat(60)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.sectionFooterHeight = UITableViewAutomaticDimension
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.matchSuper(tableView)
        _constraints.activate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.flashScrollIndicators()
    }
}

extension PlaceholderTableViewController : UITableViewDataSource {

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

extension PlaceholderTableViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}

