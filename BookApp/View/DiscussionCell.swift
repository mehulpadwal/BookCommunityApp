//
//  DiscussionCell.swift
//  BookApp
//
//  Created by Mehul Padwal on 5/4/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class DiscussionCell : UICollectionViewCell {
    
    var discId : String?
    
    let cellView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        view.layer.borderWidth = 2
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var profileImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named : "profiledefault")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 18
        iv.layer.masksToBounds = true
        iv.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        iv.layer.borderWidth = 2
        //iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        //iv.isUserInteractionEnabled = true
        return iv
        
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor(r: 0, g: 166, b: 166)
        label.textAlignment = NSTextAlignment.left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let discussionText : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.text = "review"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let discussionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.text = "review"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seprator : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
        
    }()
    
    let likeLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.text = "0 Likes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let likebutton : UIButton = {
        let iv = UIButton()
        iv.setImage(UIImage(named: "UpGreen"), for: .normal)
        //iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        //iv.image = UIImage(named: "thumbup")
        return iv
    }()
    
    
    let dislikebuton : UIButton = {
        let iv = UIButton()
        iv.setTitle("Unlike", for: .normal)
        iv.setImage(UIImage(named: "downRed"), for: .normal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupViews() {
        
        addSubview(cellView)
        
        
        cellView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 2, paddingLeft: 8, paddingBottom: 2, paddingRight: 8)
        
        cellView.addSubview(seprator)
        
        seprator.topAnchor.constraint(equalTo: cellView.topAnchor, constant : 4).isActive = true
        seprator.leftAnchor.constraint(equalTo: cellView.leftAnchor).isActive = true
        seprator.widthAnchor.constraint(equalTo: cellView.widthAnchor).isActive = true
        seprator.heightAnchor.constraint(equalToConstant: 0).isActive = true
        
        cellView.addSubview(profileImage)
        
        profileImage.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 8).isActive = true
        profileImage.topAnchor.constraint(equalTo: seprator.topAnchor, constant: 8).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 36).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        cellView.addSubview(nameLabel)
        
        nameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 12).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant : -8).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 1/2).isActive = true
        
        
        
        
        cellView.addSubview(discussionLabel)
        
        discussionLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8).isActive = true
        discussionLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 8).isActive = true
        discussionLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -8).isActive = true
        
        
        
        cellView.addSubview(discussionText)
        
        discussionText.topAnchor.constraint(equalTo: discussionLabel.bottomAnchor, constant: 8).isActive = true
        discussionText.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 8).isActive = true
        discussionText.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -8).isActive = true
        
        
        cellView.addSubview(likeLabel)
        likeLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8).isActive = true
        likeLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -8).isActive = true
        likeLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        likeLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        cellView.addSubview(likebutton)
        likebutton.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8).isActive = true
        likebutton.rightAnchor.constraint(equalTo: likeLabel.leftAnchor, constant: -4).isActive = true
        likebutton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        likebutton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        likebutton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        
        cellView.addSubview(dislikebuton)
        dislikebuton.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8).isActive = true
        dislikebuton.rightAnchor.constraint(equalTo: likeLabel.leftAnchor, constant: -4).isActive = true
        dislikebuton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        dislikebuton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        dislikebuton.addTarget(self, action: #selector(handleDisLike), for: .touchUpInside)
        dislikebuton.isHidden =  true
        
        
        
    }
    
    
    @objc func handleLike(){
        
        self.likebutton.isEnabled = false
        let ref = Database.database().reference()
        let keyToPost = ref.child("Discussion").childByAutoId().key
        ref.child("Discussion").child(discId!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if (snapshot.value as? [String: AnyObject]) != nil {
                let updateLikes: [String : Any] = ["peopleWhoLike/\(keyToPost)" : Auth.auth().currentUser!.uid]
                ref.child("Discussion").child(self.discId!).updateChildValues(updateLikes, withCompletionBlock: { (err, reff) in
                    if err == nil{
                        ref.child("Discussion").child(self.discId!).observeSingleEvent(of: .value, with: { (snap) in
                            if let properties = snap.value as? [String : AnyObject] {
                                if let likes = properties["peopleWhoLike"] as? [String : AnyObject] {
                                    let count = likes.count
                                    self.likeLabel.text = "\(count) Likes"
                                    
                                    let update = ["likes" : count]
                                    ref.child("Discussion").child(self.discId!).updateChildValues(update)
                                    
                                    self.likebutton.isHidden = true
                                    self.dislikebuton.isHidden = false
                                    self.likebutton.isEnabled = true
                                }
                            }
                            
                        }, withCancel: nil)
                    }
                })
                
                
            }
            //print(snapshot.value)
        }, withCancel: nil)
        
        
        ref.removeAllObservers()
        
    }
    
    
    @objc func handleDisLike(){
        
        self.dislikebuton.isEnabled = false
        let ref = Database.database().reference()
        ref.child("Discussion").child(discId!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let properties  = snapshot.value as? [String: AnyObject] {
                if let peopleWhoLike = properties["peopleWhoLike"] as? [String : AnyObject] {
                    for (id,person) in peopleWhoLike {
                        if person as? String == Auth.auth().currentUser!.uid {
                            ref.child("Discussion").child(self.discId!).child("peopleWhoLike").child(id).removeValue(completionBlock: { (error, reff) in
                                if error == nil {
                                    ref.child("Discussion").child(self.discId!).observeSingleEvent(of: .value, with: { (snap) in
                                        if let prop = snap.value as? [String : AnyObject] {
                                            if let likes = prop["peopleWhoLike"] as? [String : AnyObject] {
                                                let count = likes.count
                                                self.likeLabel.text = "\(count) Likes"
                                                ref.child("Discussion").child(self.discId!).updateChildValues(["likes" : count])
                                            }else {
                                                self.likeLabel.text = "0 Likes"
                                                ref.child("Discussion").child(self.discId!).updateChildValues(["likes" : 0])
                                            }
                                        }
                                    })
                                }
                            })
                            
                            self.likebutton.isHidden = false
                            self.dislikebuton.isHidden = true
                            self.dislikebuton.isEnabled = true
                            break
                            
                        }
                    }
                    
                }
                
                
            }
            //print(snapshot.value)
        }, withCancel: nil)
        
        
        ref.removeAllObservers()
        
    }
    
    
    
    
}
