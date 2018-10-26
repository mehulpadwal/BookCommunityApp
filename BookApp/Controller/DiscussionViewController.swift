//
//  DiscussionViewController.swift
//  BookApp
//
//  Created by Mehul Padwal on 4/29/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import UIKit
import Firebase

class DiscussionViewController: UIViewController {
    
    
    var selfLink = String()
    
    
    let titleLabel : UILabel = {
        let text = UILabel()
        text.text = "Title"
        text.font = UIFont.systemFont(ofSize: 14)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    let titleinput : UITextView = {
        let inp = UITextView()
        inp.font = UIFont.systemFont(ofSize: 14)
        inp.translatesAutoresizingMaskIntoConstraints = false
        
        return inp
        
    }()
    
    let textLabel : UILabel = {
        let text = UILabel()
        text.text = "Text"
        text.font = UIFont.systemFont(ofSize: 14)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    let input : UITextView = {
        let inp = UITextView()
        inp.font = UIFont.systemFont(ofSize: 14)
        inp.translatesAutoresizingMaskIntoConstraints = false
        
        return inp
        
    }()
    
    let bookLabel : UILabel = {
        let text = UILabel()
        text.text = "BookName"
        text.font = UIFont.systemFont(ofSize: 14)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    let submit : UIButton = {
        let sub = UIButton()
        sub.setTitle("Submit", for: .normal)
        sub.backgroundColor = UIColor.blue
        sub.translatesAutoresizingMaskIntoConstraints = false
        sub.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return sub
    }()
    
    func setupNavBar(){
        //navigationItem.title = list.name
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(addNewToDo))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        view.backgroundColor = UIColor.white
        view.addSubview(titleLabel)
        view.addSubview(titleinput)
        view.addSubview(textLabel)
        view.addSubview(input)
        view.addSubview(bookLabel)
        view.addSubview(submit)
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        titleinput.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        titleinput.layer.cornerRadius = 5
        titleinput.layer.borderWidth = 1
        titleinput.clipsToBounds = true
        titleinput.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        titleinput.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleinput.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        titleinput.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        textLabel.topAnchor.constraint(equalTo: titleinput.bottomAnchor, constant: 8).isActive = true
        textLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        textLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        input.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        input.layer.cornerRadius = 5
        input.layer.borderWidth = 1
        input.clipsToBounds = true
        input.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 8).isActive = true
        input.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        input.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        input.heightAnchor.constraint(equalToConstant: 150).isActive = true

        bookLabel.topAnchor.constraint(equalTo: input.bottomAnchor, constant: 8).isActive = true
        bookLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        bookLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true

        submit.topAnchor.constraint(equalTo: bookLabel.bottomAnchor, constant: 12).isActive = true
        submit.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        submit.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3)
        submit.heightAnchor.constraint(equalToConstant: 36).isActive = true

        // Do any additional setup after loading the view.
    }
    
    @objc func handleSubmit() {
        
        // print(input.text)
        
        
        //print(uid)
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
                self.registerDiscussionIntoDatabase(uid, user)
            }
            
        }, withCancel: nil)
    }
    
    
    func registerDiscussionIntoDatabase(_ uid: String, _ user: User) {
        
        let ref = Database.database().reference()
        let key = ref.child("Discussion").childByAutoId().key
        let reviewReference = ref.child("Discussion").child(key)
        
        let values = ["bookName":bookLabel.text!, "title": titleinput.text! ,"discussion": input.text!, "name" : user.name! , "profileImage" : user.profileurl!, "discId" : key , "likes" : 0, "selfLink" : selfLink] as [String : Any]
        
        reviewReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err ?? "")
                return
            }
            
            //self.movieDetailController?.fetchReviews()
            self.navigationController?.popToRootViewController(animated: true)
//            self.navigationController?.popViewController(animated: true)
//            self.navigationController?.popViewController(animated: true)
            
            
            
        })
        
        
        
        
        
    }



}
