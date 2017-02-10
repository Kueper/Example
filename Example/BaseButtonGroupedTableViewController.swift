//
//  BaseButtonGroupedTableViewController.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-19.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

/**
 Adds the base button found in BaseButtonViewController to the GroupedTableViewController
 */

class BaseButtonGroupedTableViewController: PlaceholderGroupedTableViewController {

    internal var button = PlaceholderWidthButton()
    
    override internal func setupViews() {
        super.setupViews()
        
        self.view.backgroundColor = Colour.lightGrey
        
        _views["button"] = button
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
                
        button.style = .standard
        button.addTarget(self, action: #selector(baseButtonAction(_:)), for: .touchUpInside)
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        // Override the constraints in super because we want to layout a button underneat the tableview
        _constraints.deactivate()
        _constraints = Constraint.VFLS("H:|-0-[tableView]-0-|", views: _views)
        _constraints += Constraint.VFLS("H:|-0-[button]-0-|", views: _views)
        _constraints += Constraint.VFLS("V:|-0-[tableView]-0@500-[button(60)]-0-|", views: _views)
        _constraints.activate()
    }
    
    @objc internal func baseButtonAction(_ sender: Any?) {
        
    }
}

// MARK: TableViewDataSource
extension BaseButtonGroupedTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as! TableViewCell
        return cell
    }
}

// MARK: TableViewDelegate
extension BaseButtonGroupedTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

