//
//  PlaceholderCollectionView.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-11-08.
//  Copyright © 2016 Softprint. All rights reserved.
//

import UIKit

/**
 A view containing a collection view with basic handling implemented
 
 Unsure if doing this as a view and not a view controller is the best case
 
 Because it requires manual calling of the loading methods
 
 This view determines it's own height based on the cell size and number of cells
*/
class PlaceholderCollectionView: PlaceholderView {
    
    // collection view
    internal var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // internal layout require properties
    // compute cellSize in updateView()
    // and compute rows there as well
    internal var cellSize = CGSize.zero { didSet { updateHeight() }}
    internal var rows = Int(1)
    
    // use columns here as a constant
    // so that rows and overall height can be a computed property
    internal var columns = Int(7)
    
    // characteristic height
    // can be set manually or computed with cellSize and rows
    // similarly, rows can be determined by the data model to
    // dynamically resize the view
    internal var heightConstraint = NSLayoutConstraint()

    override internal func setupViews() {
        super.setupViews()
        
        _views["collectionView"] = collectionView
        
        _views.falsifyAutoResizingMaskForViews()
        _views.safelyAddViews(to: self)
        
        // initialize collectionv view
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PlaceholderCollectionViewCell.self, forCellWithReuseIdentifier: PlaceholderCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.allowsMultipleSelection = true
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .vertical
    }
    
    override internal func setupConstraints() {
        super.setupConstraints()
        
        _constraints += Constraint.matchSuper(collectionView)
        heightConstraint = Constraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        _constraints.append(heightConstraint)
        _constraints.activate()
    }
    
    func updateView() {
        
        collectionView.reloadData()
    }
    
    private func updateHeight() {
        
        heightConstraint.constant = rows.cgFloat * cellSize.height
        collectionView.layoutIfNeeded()
    }
}

extension PlaceholderCollectionView : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}

extension PlaceholderCollectionView : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceholderCollectionViewCell.identifier, for: indexPath) as! PlaceholderCollectionViewCell
        return cell
    }
}

extension PlaceholderCollectionView : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
}
