//
//  DiscussionCollectionViewController.swift
//  BookApp
//
//  Created by Mehul Padwal on 4/28/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class DiscussionCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var discussions = [Discussion]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView?.backgroundColor = UIColor.white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Browse", style: .plain, target: self, action: #selector(handleBrowse))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(DiscussionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(DiscussionHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCell")
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
        
    

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        discussions.removeAll()
        fetchDiscussion()
        
    }
    
  

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return discussions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
            showDetailsOfDiscussion(discussion: discussions[indexPath.item])
        
    }
    
    func showDetailsOfDiscussion(discussion : Discussion) {
        let layout = UICollectionViewFlowLayout()
        let detailController = DiscussionDetailCollectionViewController(collectionViewLayout: layout)
        detailController.discussion = discussion
        navigationController?.pushViewController(detailController, animated: true)
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DiscussionCell
    
        cell.discussionLabel.text = discussions[indexPath.item].title
        cell.nameLabel.text = discussions[indexPath.item].name
        cell.discussionText.text = discussions[indexPath.item].discussion
        cell.discId = discussions[indexPath.item].discId
        let profileImageURL = discussions[indexPath.item].profileImage
        let url = URL(string : profileImageURL!)
        cell.profileImage.downloadedFrom(url: url!)
        cell.likeLabel.text = String(discussions[indexPath.item].likes!) + " Likes"
        cell.likebutton.isHidden = false
        cell.dislikebuton.isHidden = true
        
        for person in discussions[indexPath.row].peopleWhoLike {
            
            print(person + discussions[indexPath.item].title!)
            
            if let userId = Auth.auth().currentUser?.uid {
                if person == userId {
                    cell.likebutton.isHidden = true
                    cell.dislikebuton.isHidden = false
                    break
                }
            }
                
        }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as! DiscussionHeaderCell
        
        cell.searchController = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 35)
    }
    
    
    
    
    @objc func handleBrowse() {
        let discussionController = BookTabBarViewController()
        navigationController?.pushViewController(discussionController, animated: true)
        
    }
    
    func fetchDiscussion(){
        
        let dis = Database.database().reference().child("Discussion")
        
        dis.observe(.childAdded, with: { (snapshot) in
            
            //print(snapshot)
            
            if let dictionary = snapshot.value as? [String : AnyObject]{
                
                
                let disc = Discussion()
                if let dicussionText = dictionary["discussion"] as? String , let profileImage = dictionary["profileImage"] as? String, let username = dictionary["name"] as? String , let discId = dictionary["discId"] as? String, let title = dictionary["title"] as? String, let bookName = dictionary["bookName"] as? String, let selfLink = dictionary["selfLink"] as? String , let likes = dictionary["likes"] as? Int{
                    
                    
                    disc.profileImage = profileImage
                    disc.discussion = dicussionText
                    disc.name = username
                    disc.discId = discId
                    disc.title = title
                    disc.bookName = bookName
                    disc.selfLink = selfLink
                    disc.likes = likes
                    if let people = dictionary["peopleWhoLike"] as? [String: AnyObject]{
                        for (_,person) in people {
                            disc.peopleWhoLike.append(person as! String)
                        }
                        
                    }
                    
                    self.discussions.append(disc)
                
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
                
                
            }
            
        }, withCancel: nil)
        
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        if parent != nil && self.navigationItem.titleView == nil {
            fetchUserAndSetupNavBarTitle()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser?.uid == nil {
            
            performSelector(onMainThread: #selector(handleLogout), with: nil, waitUntilDone: true)
        }else{
            fetchUserAndSetupNavBarTitle()
            
        }
        setupNavBar()
        navigationController?.isNavigationBarHidden = false
    }
    
    func setupNavBar(){
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title : "Add", style: .plain, target: self, action: #selector(handleDiscussion))
        navigationController?.navigationBar.tintColor = UIColor(r: 0, g: 166, b: 166)
        navigationController?.navigationBar.barTintColor = UIColor.orange
        //navigationController?.navigationBar.isTranslucent = false
        
    }
    
    @objc func handleDiscussion(){
        let layout = UICollectionViewFlowLayout()
        let tempController = DiscussionCollectionViewController(collectionViewLayout: layout)
        navigationController?.pushViewController(tempController, animated: true)
    }
    
    @objc func handleLogout()  {
        do{
            //print("vfd")
            try Auth.auth().signOut()
        }catch let logoutError {
            print(logoutError)
        }
        
        let logoutViewController = LoginViewController()
        logoutViewController.ListViewController = self
        present(logoutViewController, animated: true, completion: nil)
    }
    
    func setupNavBarWithUser(_ user: User) {
        
        let titleView = TitleView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        
        self.navigationItem.titleView = titleView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        titleView.isUserInteractionEnabled = true
        
        titleView.addGestureRecognizer(tap)
        
        if let profileImageUrl = user.profileurl {
            titleView.profileImageView.downloadImageUsingCacheWithLink(profileImageUrl)
            
        }
        titleView.nameLabel.text = user.name
        
    }
    
    func fetchUserAndSetupNavBarTitle() {
        guard let uid = Auth.auth().currentUser?.uid else {
            //for some reason uid = nil
            return
        }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User(dictionary: dictionary)
                self.setupNavBarWithUser(user)
            }
            
        }, withCancel: nil)
    }
    
    // When NavBar TitleView is Tapped!!! Edit User Profile!!!
    @objc private func handleTap(){
        //print("Tapped")
        
        let registeController = RegisterViewController()
        registeController.ListViewController = self
        
        registeController.fetchUserProfile()
        
        navigationController?.pushViewController(registeController, animated: true)
    }


}
