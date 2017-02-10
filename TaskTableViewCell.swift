//
//  TaskTableViewCell.swift
//  LifePath
//
//  Created by Eric Kueper on 2017-02-02.
//  Copyright © 2017 Kueper. All rights reserved.
//

import UIKit

class TaskTableViewCell: TableViewCell {
    
    internal let label = UILabel()
    
    var task: Task? { didSet {
        self.label.text = self.task?.name
        }}
    
    let tableView = TaskTableView(frame: CGRect.zero, style: .plain)

    var heightC = NSLayoutConstraint()
    
    override func setupViews() {
        super.setupViews()
        
        self.contentView.addSubview(tableView)
        
        _views["tableView"] = tableView
        _views["label"] = label

        _views.falsifyAutoResizingMaskForViews()
        _views.safelyAddViews(to: self.contentView)
        
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        ["H:|-20-[label]-12-|",
         "V:|-8-[label(30)]-8-[tableView]-0-|",
         "H:|-40-[tableView]-0-|",].constraints(on: _views).activate()
    }
}
















