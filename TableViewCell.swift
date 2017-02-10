//
//  TableViewCell.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-06.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit
import Foundation

class TableViewCell: UITableViewCell {
    
    static var identifier: String { return String(describing: self) }
        
    internal var _constraints = [NSLayoutConstraint]()
    internal var _views = [String : UIView]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }

    internal func setupViews() {
        // default hizentra settings
        self.detailTextLabel?.font = UIFont.Avenir(size: 12)
        
        self.tintColor = Colour.hizentraBlue
        
        self.textLabel?.font = UIFont.Avenir(size: 16)
        self.textLabel?.textColor = Colour.charcoal
        self.textLabel?.adjustsFontSizeToFitWidth = true
        
        self.detailTextLabel?.font = UIFont.Avenir(size: 14)
        self.detailTextLabel?.textColor = Colour.charcoal
        self.detailTextLabel?.adjustsFontSizeToFitWidth = true
    }
    
    internal func setupConstraints() {
        
    }
}
