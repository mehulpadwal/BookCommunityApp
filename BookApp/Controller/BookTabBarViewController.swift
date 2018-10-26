//
//  BookTabBarViewController.swift
//  BookApp
//
//  Created by Mehul Padwal on 4/27/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import UIKit
import Firebase

class BookTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        setupTabBar()
    }
    
    func setupTabBar(){
       
        
        let layout = UICollectionViewFlowLayout()
        let bookListViewController = BookListController(collectionViewLayout: layout)
        bookListViewController.genre = "fantasy"
        let nav1 = UINavigationController(rootViewController: bookListViewController)
        nav1.navigationItem.title = "Fiction"
        nav1.tabBarItem.image = UIImage(named: "favourite")
        nav1.title = "Fiction"
        
        let dramalayout = UICollectionViewFlowLayout()
        let bookListViewController2 = BookListController(collectionViewLayout: dramalayout)
        bookListViewController2.genre = "drama"
        let nav2 = UINavigationController(rootViewController: bookListViewController2)
        nav2.navigationItem.title = "Drama"
        nav2.tabBarItem.image = UIImage(named: "favourite")
        nav2.title = "Drama"
        
        
        
  
        let favoritelayout = UICollectionViewFlowLayout()
        let favoriteViewController = FavouritesCollectionViewController(collectionViewLayout: favoritelayout)
        let navcontroller = UINavigationController(rootViewController: favoriteViewController)
        navcontroller.title = "Favorites"
        navcontroller.navigationItem.title = "Favorites"
        navcontroller.tabBarItem.image = UIImage(named: "favourite")
        
      
        
        
        viewControllers = [nav1, nav2, navcontroller]
        
    }
    
    

}
