//
//  FavouritesCollectionViewController.swift
//  BookApp
//
//  Created by Mehul Padwal on 5/1/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import UIKit
import Firebase


private let reuseIdentifier = "Cell"



class FavouritesCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    
    var books = [FavoriteBook]()
    
    //Change when clicked on favorite button

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        
      

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(BookCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }

        // Do any additional setup after loading the view.
    }



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(books.count)
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width)/3 - 15, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BookCell
        
        cell.bookLabel.text = books[indexPath.item].name
        
        let urlString = books[indexPath.item].image
        let url = URL(string : urlString!)
        cell.bookImage.downloadedFrom(url: url!)
        cell.unfavorButton.isHidden = false
      
        
    
        return cell
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        books.removeAll()
        fetchFavorties()
        
    }
    
    func fetchFavorties(){
        
        let fav = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("favorites")
        fav.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                
                //print(dictionary)
                let favorite = FavoriteBook()
                if let bookLink = dictionary["link"] as? String , let image = dictionary["image"] as? String, let name = dictionary["name"] as? String{
                    favorite.link = bookLink
                    favorite.image = image
                    favorite.name = name
                    print(name)
                    print(image)
                    self.books.append(favorite)
                    
                }
                
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
                
                
            }
            
        }, withCancel: nil)
        
    }

  

}
