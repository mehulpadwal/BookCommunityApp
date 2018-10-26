//
//  LoginViewController.swift
//  FireReview
//
//  Created by Mehul Padwal on 4/6/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var ListViewController: DiscussionCollectionViewController?
    
    
    let backgroundImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named : "background")
        iv.translatesAutoresizingMaskIntoConstraints = false
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
        return tf
        
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        
        tf.setLeftPaddingPoints(10)
        tf.attributedPlaceholder = NSAttributedString(string: "Password" , attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.textColor = UIColor.white
        tf.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 5
        tf.isSecureTextEntry = true
        tf.clipsToBounds = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    
    let loginButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 0, g: 166, b: 166)
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 18
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    
    
    @objc func handleLogin() {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            print("Successfully logged in")
            
            //get fetchuser
            self.ListViewController?.fetchUserAndSetupNavBarTitle()
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    @objc func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Must enter email,password ")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            guard (user?.uid) != nil else {
                return
            }
            
            print("User registered")
            
            let registerViewController = RegisterViewController()
            //registerViewController.viewController self.viewController
            registerViewController.email = email
            registerViewController.password = password
            
            //self.dismiss(animated: true, completion: nil)
            self.ListViewController?.navigationController?.pushViewController(registerViewController, animated: true)
            registerViewController.ListViewController = self.ListViewController
            //self.present(registerViewController, animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        })
        
//        print("Register")
//        let registerController = RegisterViewController()
//        self.present(registerController, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupInputs()
        
        
        
        //view.backgroundColor = UIColor.red
        
        

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
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -12).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        
        
    }
    

}
