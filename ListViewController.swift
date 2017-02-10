//
//  ListViewController.swift
//  LifePath
//
//  Created by Eric Kueper on 2017-02-02.
//  Copyright © 2017 Kueper. All rights reserved.
//

import UIKit

class ListViewController: PlaceholderTableViewController {
    
    override internal func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override internal func setupViews() {
        super.setupViews()
        
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
    }
    
    override internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return List.shared.tasks.count
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as! TaskTableViewCell
        
        let task = List.shared.tasks[indexPath.row]
        
        cell.task = task
        
        return cell
    }

}
