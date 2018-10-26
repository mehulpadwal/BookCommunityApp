//
//  SearchCollectionViewController.swift
//  BookApp
//
//  Created by Mehul Padwal on 5/4/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class SearchCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout , UISearchBarDelegate{
    
    var results : BookResults?
    let cellId = "cellID"
    
    lazy var searchBar : UISearchBar = {
        let s = UISearchBar()
        s.placeholder = "Search"
        s.delegate = self
        s.tintColor = .white
        s.barTintColor = UIColor.white
        s.barStyle = .default
        s.sizeToFit()
        s.setCellShadow()
        return s
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(BookCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCellId")

        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCellId", for: indexPath)
        header.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = results?.items.count{
            
            print(count)
            return count
            
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BookCell
    
        let urlString = results?.items[indexPath.item].thumbnail
        let thumbUrl = URL(string: urlString!)
        cell.bookImage.downloadedFrom(url: thumbUrl!)
        cell.bookLabel.text = results?.items[indexPath.item].title
        cell.selfLink = results?.items[indexPath.item].selfLink
        cell.imageLink = urlString
        
        if let bookName = results?.items[indexPath.item].title {
            
            
            let fav = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("favorites")
            fav.observe(.childAdded, with: { (snapshot) in
                if let properties = snapshot.value as? [String : AnyObject] {
                    
                    if let favMovie = properties["name"] as? String {
                        if favMovie == bookName{
                            print(favMovie)
                            cell.favorButton.isHidden = true
                            cell.unfavorButton.isHidden = false
                            cell.unfavorButton.isEnabled = true
                            
                        }
                    }
                }
            }, withCancel: nil)
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width)/3 - 15, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        showDiscussionPage(bookName: (results?.items[indexPath.item].title)!, selfLink: (results?.items[indexPath.item].selfLink)!)
        
    }
    
    func showDiscussionPage(bookName: String,selfLink : String) {
        //let layout = UICollectionViewFlowLayout()
        let detailController = DiscussionViewController()
        detailController.selfLink = selfLink
        detailController.bookLabel.text = bookName
        navigationController?.pushViewController(detailController, animated: true)
        //navigationController?.popViewController(animated: true)
        //navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //print(searchBar.text)g
        if let searchtext = searchBar.text{
            
            let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(searchtext.removingWhitespaces())&maxResults=20&startIndex=0&langRestrict=en&key=AIzaSyDEitgO5m-K60ckaYJdjnC2xfOAQh3Pq7c"
            
            
            let url = URL(string : urlString)
            
            
            URLSession.shared.dataTask(with: url!) { (data, response, err) in
                if err == nil{
                    
                    guard let jsondata = data else { return }
                    do{
                        
                        self.results = try JSONDecoder().decode(BookResults.self, from: jsondata)
                        
                        DispatchQueue.main.async{
                            
                            self.collectionView?.reloadData()
                            //completed()
                        }
                    }catch let error{
                        print(error)
                    }
                }
                }.resume()
            
            
            print(urlString)
        }
        
        
        
        
    }
    


}
