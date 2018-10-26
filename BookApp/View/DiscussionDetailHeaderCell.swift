//
//  DiscussionDetailHeaderCell.swift
//  BookApp
//
//  Created by Mehul Padwal on 5/4/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DiscussionDetailHeaderCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var selfLink : String?
    
    let nameLabel : UILabel = {
        let text = UILabel()
        text.text = "username"
        text.font = UIFont.systemFont(ofSize: 8)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let DiscussionLabel : UILabel = {
        let text = UILabel()
        text.text = "Title"
        text.numberOfLines = 2
        text.textColor = UIColor(r: 0, g: 166, b: 166)
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    

    
    
    let commentLabel : UILabel = {
        let text = UILabel()
        text.text = "Comment"
        text.font = UIFont.systemFont(ofSize: 14)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let DiscussionText : UILabel = {
        let text = UILabel()
        text.text = "Discussion"
        text.numberOfLines = 0
        text.textColor = UIColor(r: 0, g: 166, b: 166)
        text.font = UIFont.systemFont(ofSize: 14)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let seperator : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.gray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
        
    }()
    
    
    let AboutLabel : UILabel = {
        let text = UILabel()
        text.text = "About:"
        text.font = UIFont.systemFont(ofSize: 14)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
  
    
    let BookNameButton : UIButton = {
        let sub = UIButton()
        sub.setTitle("Book Name", for: .normal)
        sub.setTitleColor(UIColor.red, for: .normal)
        //sub.tintColor = UIColor.blackß
        //sub.backgroundColor = UIColor.gray
        //sub.underlineButton(text: "Book Name")
        sub.translatesAutoresizingMaskIntoConstraints = false
        
        return sub
    }()
    
    let seperator2 : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.gray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
        
    }()
    
    let input : UITextView = {
        let inp = UITextView()
        inp.font = UIFont.systemFont(ofSize: 14)
        inp.translatesAutoresizingMaskIntoConstraints = false
        
        return inp
        
    }()
    
    let submit : UIButton = {
        let sub = UIButton()
        sub.setTitle("Submit", for: .normal)
        sub.backgroundColor = UIColor.blue
        sub.translatesAutoresizingMaskIntoConstraints = false
        
        return sub
    }()
    
    let seperator3 : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.gray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
        
    }()
    
    func setupViews(){
        //backgroundColor = UIColor.black
        
        addSubview(nameLabel)
        
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: 8).isActive = true
        
//        addSubview(BookNameButton)
//
//        BookNameButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
//        BookNameButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
//        BookNameButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -8).isActive = true
//        BookNameButton.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        addSubview(DiscussionLabel)
        
        DiscussionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        DiscussionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        DiscussionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        
        addSubview(DiscussionText)
        
        
        DiscussionText.topAnchor.constraint(equalTo: DiscussionLabel.bottomAnchor, constant: 8).isActive = true
        DiscussionText.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        DiscussionText.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        
        addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: DiscussionText.bottomAnchor, constant : 4).isActive = true
        seperator.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        seperator.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(AboutLabel)
        
        
        AboutLabel.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 4).isActive = true
        AboutLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        AboutLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        AboutLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(BookNameButton)
        
        BookNameButton.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 4).isActive = true
        BookNameButton.leftAnchor.constraint(equalTo: AboutLabel.rightAnchor, constant: 8).isActive = true
        BookNameButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        BookNameButton.addTarget(self, action: #selector(handleDetail), for: .touchUpInside)
        //BookNameButton.widthAnchor.
        
        addSubview(seperator2)
        
        seperator2.topAnchor.constraint(equalTo: BookNameButton.bottomAnchor, constant : 4).isActive = true
        seperator2.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        seperator2.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        seperator2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    
        
        addSubview(commentLabel)
        
        commentLabel.topAnchor.constraint(equalTo: seperator2.bottomAnchor, constant: 4 ).isActive = true
        commentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        commentLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        
        addSubview(input)
        
        input.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 4).isActive = true
        input.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        input.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        input.heightAnchor.constraint(equalToConstant: 60).isActive = true
        input.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        input.layer.cornerRadius = 5
        input.layer.borderWidth = 1
        input.clipsToBounds = true
        
        addSubview(submit)
        
        submit.topAnchor.constraint(equalTo: input.bottomAnchor, constant: 4).isActive = true
        submit.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        submit.widthAnchor.constraint(equalToConstant: 60).isActive = true
        submit.heightAnchor.constraint(equalToConstant: 20).isActive = true
        submit.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        
        addSubview(seperator3)
        seperator3.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator3.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        seperator3.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        seperator3.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        
        
    }
    
    @objc func handleSubmit(){
        fetchUser()
        
    }
    
    
    func fetchUser() {

        guard let uid = Auth.auth().currentUser?.uid else {
            //for some reason uid = nil
            return
        }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User(dictionary: dictionary)
                self.registerCommentIntoDatabase(uid, user)
            }
            
        }, withCancel: nil)
    }
    
    var discId : String?
    
    func registerCommentIntoDatabase(_ uid: String, _ user: User) {
        
        let ref = Database.database().reference()
        //print(discId)
        let key  = ref.child("Discussion").child(discId!).child("comments").childByAutoId().key
        let reviewReference = ref.child("Discussion").child(discId!).child("comments").child(key)
        
        let values = ["discussion": input.text!, "name" : user.name! , "profileImage" : user.profileurl!] as [String : Any]
        
        reviewReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err ?? "")
                return
            }
            
            //self.movieDetailController?.fetchReviews()
           // self.navigationController?.popViewController(animated: true)
            
            
            
        })
        
        
        
        
        
    }
    
    
    var navViewController : UICollectionViewController?
    
    @objc func handleDetail(){
        let layout = UICollectionViewFlowLayout()
        let detailController = BookDetailViewController(collectionViewLayout: layout)
        detailController.selfLink = selfLink
        navViewController?.navigationController?.pushViewController(detailController, animated: true)
    }
    
}
