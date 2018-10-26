//
//  RegisterViewController.swift
//  FireReview
//
//  Created by Mehul Padwal on 4/6/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController ,  UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    var ListViewController: DiscussionCollectionViewController?
    var email : String?
    var password : String?
    var profileurl: String?
    
    
    let backgroundImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named : "background")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    lazy var profileImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named : "profiledefault")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 75
        iv.layer.masksToBounds = true
        iv.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        iv.layer.borderWidth = 2
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        iv.isUserInteractionEnabled = true
        return iv
        
    }()
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Email" , attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.setLeftPaddingPoints(10)
        tf.textColor = UIColor.white
        tf.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.allowsEditingTextAttributes = false
        return tf
        
    }()
    
    
    let nameTextField : UITextField = {
        let tf = UITextField()
        
        tf.setLeftPaddingPoints(10)
        tf.attributedPlaceholder = NSAttributedString(string: "Username" , attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.textColor = UIColor.white
        tf.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    
    let companyTextField : UITextField = {
        let tf = UITextField()
        
        tf.setLeftPaddingPoints(10)
        tf.attributedPlaceholder = NSAttributedString(string: "Company" , attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.textColor = UIColor.white
        tf.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    
    let workTextField : UITextField = {
        let tf = UITextField()
        
        tf.setLeftPaddingPoints(10)
        tf.attributedPlaceholder = NSAttributedString(string: "Work" , attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.textColor = UIColor.white
        tf.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    let locationTextField : UITextField = {
        let tf = UITextField()
        
        tf.setLeftPaddingPoints(10)
        tf.attributedPlaceholder = NSAttributedString(string: "Location" , attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.textColor = UIColor.white
        tf.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 5
        tf.clipsToBounds = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    
    
    
    let registerButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 0, g: 166, b: 166)
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 18
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancelButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 0, g: 166, b: 166)
        button.setTitle("Cancel", for: .normal)
        button.layer.cornerRadius = 18
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    @objc func handleRegister() {
        
        print("Register")
        
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        //successfully authenticated user
        
        // upload profile image
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
        
        // Compress Image into JPEG type
        if let profileImage = self.profileImage.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
            
            _ = storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    print("Error when uploading profile image")
                    return
                }
                // Metadata contains file metadata such as size, content-type, and download URL.
                self.profileurl = metadata.downloadURL()?.absoluteString
                self.registerUserIntoDatabaseWithUID(uid)
            }
        }
    }
    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid)
        
        let values = ["name": nameTextField.text, "email": email, "company": companyTextField.text, "work": workTextField.text, "location": locationTextField.text, "profileurl": profileurl] as [String : AnyObject]
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err ?? "")
                return
            }
            
            self.ListViewController?.fetchUserAndSetupNavBarTitle()
            //self.dismiss(animated: true, completion: nil)
            self.ListViewController?.navigationController?.popViewController(animated: true)
            
            
        })
    }
    
    @objc func handleCancel() {
        print("Register")
        self.ListViewController?.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupInputs()
        
        self.navigationController?.isNavigationBarHidden = true;
        
        if let email = email {
            emailTextField.text = email
        }
        

        // Do any additional setup after loading the view.
    }
    
    func setupBackground() {
        
        view.addSubview(backgroundImage)
        
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    
    func setupInputs() {
        
        view.addSubview(profileImage)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(companyTextField)
        view.addSubview(workTextField)
        view.addSubview(locationTextField)
        view.addSubview(registerButton)
        view.addSubview(cancelButton)
        
        profileImage.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -12).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        nameTextField.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -12).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailTextField.bottomAnchor.constraint(equalTo: companyTextField.topAnchor, constant: -12).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        companyTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 12).isActive = true
        companyTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        companyTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        companyTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        workTextField.topAnchor.constraint(equalTo: companyTextField.bottomAnchor, constant: 12).isActive = true
        workTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        workTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        workTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        locationTextField.topAnchor.constraint(equalTo: workTextField.bottomAnchor, constant: 12).isActive = true
        locationTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        locationTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        registerButton.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 12).isActive = true
        registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12) .isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2 , constant : -24).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 12).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: registerButton.rightAnchor, constant: 24) .isActive = true
        //cancelButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12)
        cancelButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2 , constant : -24).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    
    func fetchUserProfile() {
        guard let uid = Auth.auth().currentUser?.uid else {
            //for some reason uid = nil
            return
        }
        // Read User information from DB
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                //                self.navigationItem.title = dictionary["name"] as? String
                
                let user = User(dictionary: dictionary)
                self.setupProfileWithUser(user)
            }
            
        }, withCancel: nil)
    }
    
    func setupProfileWithUser(_ user: User) {
        email = user.email
        if let url = user.profileurl {
            profileImage.downloadImageUsingCacheWithLink(url)
        }
        if let name = user.name {
            nameTextField.text = name
        }
        if let company = user.company {
            companyTextField.text = company
        }
        if let work = user.work {
            workTextField.text = work
        }
        if let location = user.location {
            locationTextField.text = location
        }
    }
    
    
    @objc func handleSelectProfileImageView() {
        
        print("dsd")
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        // show Image Picker!!!! (Modally)
        present(picker, animated: true, completion: nil)
    }
    
    // UIImagePickerController Delegates!!!
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImage.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }

}
