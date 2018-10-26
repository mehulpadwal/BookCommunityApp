//
//  BookCell.swift
//  BookApp
//
//  Created by Mehul Padwal on 4/27/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class  BookCell: UICollectionViewCell {
    
    
    let cellView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setCellShadow()
        return view
    }()
    
    let bookImage : UIImageView = {
        let imagev  = UIImageView()
        imagev.translatesAutoresizingMaskIntoConstraints = false
        imagev.contentMode = .scaleAspectFill
        imagev.image = UIImage(named : "bookDefault")
        return imagev
    }()
    
    let favorButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        let image = UIImage(named : "favorite1")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var selfLink : String?
    var imageLink : String?
    
    
    let unfavorButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        let image = UIImage(named : "favorite2")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    let bookLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.left
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func handleUnFav(){
        
        let uid = Auth.auth().currentUser!.uid
        self.unfavorButton.isEnabled = false
        let ref = Database.database().reference()
        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let properties = snapshot.value as? [String : AnyObject] {
                if let favMovie = properties["favorites"] as? [String:AnyObject] {
                    for (movie, _) in favMovie {
                        
                        if movie == self.bookLabel.text!{
                            ref.child("users").child(uid).child("favorites").child(movie).removeValue(completionBlock: { (err, reff) in
                                if err == nil {
                                    self.favorButton.isHidden = false
                                    self.unfavorButton.isHidden = true
                                    self.unfavorButton.isEnabled = true
                                }
                            })
                        }
                    }
                }
            }
            
            
        }, withCancel: nil)
        
        
    }
    
    @objc func handleFav(){
        self.favorButton.isEnabled = false
        
        let uid = Auth.auth().currentUser!.uid
        
        let ref = Database.database().reference()
        //let keyToFav    = ref.child("favorites").childByAutoId().key
        //let updatefav: [String : Any] = ["fav/\(keyToPost)" : titleLabel.text]
        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if (snapshot.value as? [String: AnyObject]) != nil {
                //let favMovie : [String : Any] = ["favorites/\(self.bookLabel.text!)" : self.selfLink ?? "" ]
                
                let values = ["link" : self.selfLink!, "image" : self.imageLink!, "name" : self.bookLabel.text!] as [String :Any]
                ref.child("users").child(uid).child("favorites").child(self.bookLabel.text!).updateChildValues(values, withCompletionBlock: { (err, reff) in
                    
                    if err == nil {
                        self.favorButton.isHidden = true
                        self.unfavorButton.isHidden = false
                        self.favorButton.isEnabled = true
                    }
                    
                })
            }
        },withCancel : nil)
        
    }
    
    
    func setupViews(){
        
        //self.backgroundColor = UIColor.red
        addSubview(cellView)
        
        cellView.topAnchor.constraint(equalTo: topAnchor).isActive =  true
        cellView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cellView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        cellView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        
        cellView.addSubview(bookImage)
        
        bookImage.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        bookImage.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        bookImage.widthAnchor.constraint(equalToConstant : 110).isActive = true
        bookImage.heightAnchor.constraint(equalToConstant: 177).isActive = true
        
        cellView.addSubview(bookLabel)
        
        bookLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 8).isActive = true
        bookLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 8).isActive = true
        bookLabel.widthAnchor.constraint(equalTo: cellView.widthAnchor, constant: -8).isActive = true
       // bookLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        cellView.addSubview(favorButton)
        
        favorButton.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8).isActive = true
        favorButton.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -8).isActive = true
        favorButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        favorButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        favorButton.addTarget(self, action: #selector(handleFav), for: .touchUpInside)
        
        cellView.addSubview(unfavorButton)
        
        unfavorButton.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8).isActive = true
        unfavorButton.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -8).isActive = true
        unfavorButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        unfavorButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        unfavorButton.isHidden = true
        unfavorButton.addTarget(self, action: #selector(handleUnFav), for: .touchUpInside)


        
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
