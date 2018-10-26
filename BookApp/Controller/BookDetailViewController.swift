//
//  BookDetailViewController.swift
//  BookApp
//
//  Created by Mehul Padwal on 4/27/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import UIKit
import Firebase

class BookDetailViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    let headerCell = "headerCell"
    
    var bookTitle: String?
    var publisher : String?
    var bookCoverLink : String?
    var book_description: String?
    var previewLink : String?
    
    var selfLink : String? {
        didSet{
            let link = selfLink
            let url = URL(string : link!)
            var result : BookInfo?
            URLSession.shared.dataTask(with: url!) { (data, response, err) in
                if err == nil{
                    
                    guard let jsondata = data else { return }
                    do{
                        result = try JSONDecoder().decode(BookInfo.self, from: jsondata)
                        self.bookTitle = result?.title
                        self.publisher = result?.publisher
                        self.bookCoverLink = result?.thumbnail
                        self.book_description = result?.description
                        self.previewLink = result?.infoLink
                       // print(result?.title)
                        
                        DispatchQueue.main.async{
                            self.collectionView?.reloadData()
                        }
                        
                        
                    }catch let error{
                        print(error)
                    }
                }
                }.resume()
        }
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCell, for: indexPath) as! BookDetailCell
        if let title = bookTitle{
            print(title)
            let url = URL(string : bookCoverLink!)
            cell.imageView.downloadedFrom(url: url!)
            cell.bookName.text = bookTitle
            cell.publisher.text = publisher
            cell.descriptionText.text = book_description?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            cell.navController = self
            cell.previewLink = previewLink
            //StringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
            return cell
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.isToolbarHidden =  true
        setupCollectionView()
        
        // Do any additional setup after loading the view.
    }
    
    func setupCollectionView(){
        //collectionView?.contentInset = UIEdinset
        collectionView?.backgroundColor = UIColor.white
        //collectionView?.contentInset = UIEdgeInsets(top: -45 , left: 0 , bottom: 0 , right: 0)
        collectionView?.register(BookDetailCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 1000)
    }
    
    


}
