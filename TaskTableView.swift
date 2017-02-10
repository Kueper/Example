//
//  TaskTableViewController.swift
//  LifePath
//
//  Created by Eric Kueper on 2017-02-10.
//  Copyright © 2017 Kueper. All rights reserved.
//

import UIKit

class TaskTableView: UITableView {
    
    var task: Task? { didSet {
        self.reloadData()
        }}
    
    fileprivate var _constraints = [NSLayoutConstraint]()
    fileprivate let _views = [String : UIView]()
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        
        self.delegate = self
        self.dataSource = self
        
        self.estimatedRowHeight = 64.cgFloat
        self.rowHeight = UITableViewAutomaticDimension
        
        self.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        
        self.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        
        self.tableFooterView = UIView(frame: CGRect.zero)
        
        // self.isScrollEnabled = false
    }
    
    func setupConstraints() {
        
    }
    
}

extension TaskTableView: UITableViewDelegate {
    
    
    
}

extension TaskTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // section agnostic, 1 section
        let tasks = task?.subtasks.count ?? 0
        
        return tasks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as! TaskTableViewCell
        
        let _task = task?.subtasks[indexPath.row]
        cell.task = _task
        
        return cell
    }
}
