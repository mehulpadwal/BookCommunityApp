//
//  DiscussionHeader.swift
//  BookApp
//
//  Created by Mehul Padwal on 5/4/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import Foundation
import UIKit

class DiscussionHeaderCell: UICollectionViewCell {
    
    var searchController : UICollectionViewController?
    
    let discussionLabel : UILabel = {
        let text = UILabel()
        text.text = "Discussions"
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
        
    }()
    
    let addButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named : "PEN2"), for: .normal)
       // button.backgroundColor = UIColor.black
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(discussionLabel)
        
        discussionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        discussionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        discussionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2).isActive = true
        
        addSubview(addButton)
        
        addButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        addButton.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addButton.addTarget(self, action: #selector(handleAddDiscussion), for: .touchUpInside)
    }
    
    @objc func handleAddDiscussion(){
        
        let layout = UICollectionViewFlowLayout()
        let search = SearchCollectionViewController(collectionViewLayout: layout)
        searchController?.navigationController?.pushViewController(search, animated: true)
        
        
    }
}
