//
//  DiscussionDetailCollectionViewController.swift
//  BookApp
//
//  Created by Mehul Padwal on 4/28/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
private let headerCell = "headerCell"

class DiscussionDetailCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    
    var discussion = Discussion()
    
    var comments = [Comment]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView?.register(DiscussionDetailHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCell)
        self.collectionView!.register(ReviewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        fetchComments()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 

  
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCell, for: indexPath) as! DiscussionDetailHeaderCell
        
        cell.nameLabel.text = "u/"+discussion.name!
        cell.BookNameButton.setTitle(discussion.bookName, for: .normal)
        cell.DiscussionLabel.text = discussion.title
        cell.DiscussionText.text = discussion.discussion
        cell.discId = discussion.discId
        cell.selfLink = discussion.selfLink
        cell.navViewController = self
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReviewCell
        
        
        // Configure the cell
        cell.nameLabel.text = comments[indexPath.item].name
        cell.reviewLabel.text = comments[indexPath.item].discussion
        let profileURL = comments[indexPath.item].profileImage
        let url = URL(string : profileURL!)
        cell.profileImage.downloadedFrom(url: url!)
        
    
        return cell
    }
    
    
    func fetchComments(){
        let ref = Database.database().reference().child("Discussion").child(discussion.discId!).child("comments")
        
        ref.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary  = snapshot.value as? [String : AnyObject]{
                let com = Comment()
                
                if let comment = dictionary["discussion"] as? String , let profileImage = dictionary["profileImage"] as? String, let username = dictionary["name"] as? String {
                    print(comment)
                    com.discussion = comment
                    com.name = username
                    com.profileImage = profileImage
                    
                    self.comments.append(com)
                    
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        
            
        }, withCancel: nil)
        
    }
    
        
    
    
   
    
    


}
