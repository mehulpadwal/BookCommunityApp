//
//  ReviewCell.swift
//  FireReview
//
//  Created by Mehul Padwal on 4/7/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class ReviewCell: UICollectionViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        view.layer.borderWidth = 2
        view.isUserInteractionEnabled = true
        //view.setCellShadow()
        return view
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    
    
    
    let likeLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.left
        label.text = "0 Likes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let likebutton : UIButton = {
        let iv = UIButton()
        iv.setTitle("Like", for: .normal)
        //iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        iv.layer.borderWidth = 2
        iv.translatesAutoresizingMaskIntoConstraints = false
        //iv.image = UIImage(named: "thumbup")
        return iv
    }()
    
    
    let dislikebuton : UIButton = {
        let iv = UIButton()
        iv.setTitle("Unlike", for: .normal)
        iv.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        iv.layer.borderWidth = 2
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    var reviewId: String!
    var movieTitle : String!
    
    
    @objc func handledislike() {
        
        self.dislikebuton.isEnabled = false
        let ref = Database.database().reference()
        ref.child("reviews").child(movieTitle).child(reviewId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let properties  = snapshot.value as? [String: AnyObject] {
                if let peopleWhoLike = properties["peopleWhoLike"] as? [String : AnyObject] {
                    for (id,person) in peopleWhoLike {
                        if person as? String == Auth.auth().currentUser!.uid {
                            ref.child("reviews").child(self.movieTitle).child(self.reviewId).child("peopleWhoLike").child(id).removeValue(completionBlock: { (error, reff) in
                                if error == nil {
                                    ref.child("reviews").child(self.movieTitle).child(self.reviewId).observeSingleEvent(of: .value, with: { (snap) in
                                        if let prop = snap.value as? [String : AnyObject] {
                                            if let likes = prop["peopleWhoLike"] as? [String : AnyObject] {
                                                let count = likes.count
                                                self.likeLabel.text = "\(count) Likes"
                                                ref.child("reviews").child(self.movieTitle).child(self.reviewId).updateChildValues(["likes" : count])
                                            }else {
                                                self.likeLabel.text = "0 Likes"
                                                ref.child("reviews").child(self.movieTitle).child(self.reviewId).updateChildValues(["likes" : 0])
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
    
    @objc func handlelike() {
        
        self.likebutton.isEnabled = false
        let ref = Database.database().reference()
        let keyToPost = ref.child("posts").childByAutoId().key
        ref.child("reviews").child(movieTitle).child(reviewId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if (snapshot.value as? [String: AnyObject]) != nil {
                let updateLikes: [String : Any] = ["peopleWhoLike/\(keyToPost)" : Auth.auth().currentUser!.uid]
                ref.child("reviews").child(self.movieTitle).child(self.reviewId).updateChildValues(updateLikes, withCompletionBlock: { (err, reff) in
                    if err == nil{
                        ref.child("reviews").child(self.movieTitle).child(self.reviewId).observeSingleEvent(of: .value, with: { (snap) in
                            if let properties = snap.value as? [String : AnyObject] {
                                if let likes = properties["peopleWhoLike"] as? [String : AnyObject] {
                                    let count = likes.count
                                    self.likeLabel.text = "\(count) Likes"
                                    
                                    let update = ["likes" : count]
                                    ref.child("reviews").child(self.movieTitle).child(self.reviewId).updateChildValues(update)
                                    
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
    
    
    let reviewLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.left
        label.text = "review"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    lazy var profileImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named : "background")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 18
        iv.layer.masksToBounds = true
        iv.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        iv.layer.borderWidth = 2
        //iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        //iv.isUserInteractionEnabled = true
        return iv
        
    }()
    
    
    let seprator : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
        
    }()
    
    let seprator1 : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        addSubview(cellView)
        
        
        cellView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 4, paddingRight: 8)
        
        cellView.addSubview(profileImage)
        cellView.addSubview(nameLabel)
        cellView.addSubview(seprator)
        cellView.addSubview(reviewLabel)
        
        profileImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8).isActive = true
        profileImage.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 8).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 36).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        
        
        nameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 12).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant : -8).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 1/2).isActive = true
        


       
        
      
        
     
        
        seprator.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant : 4).isActive = true
        seprator.leftAnchor.constraint(equalTo: cellView.leftAnchor).isActive = true
        seprator.widthAnchor.constraint(equalTo: cellView.widthAnchor).isActive = true
        seprator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        
        reviewLabel.topAnchor.constraint(equalTo: seprator.bottomAnchor, constant : 4).isActive = true
        reviewLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant : 6).isActive = true
        reviewLabel.widthAnchor.constraint(equalTo: cellView.widthAnchor, constant: -12).isActive = true
        //reviewLabel.heightAnchor.constraint(equalTo: cellView.heightAnchor , multiplier : 2/3).isActive = true
        
        
        
    }
}
