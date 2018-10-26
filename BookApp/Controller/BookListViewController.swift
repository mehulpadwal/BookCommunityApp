//
//  ViewController.swift
//  BookApp
//
//  Created by Mehul Padwal on 4/25/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import UIKit

class BookListViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    var results : BookResults?
    var cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(BookCell.self, forCellWithReuseIdentifier: cellId)
        // Do any additional setup after loading the view, typically from a nib.
        downloadJSON {
        }
        
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = results?.items.count{
            return count
        }
        return 0
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BookCell
        cell.title.text = results?.items[indexPath.item].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func downloadJSON(completed: @escaping () -> ()){
        
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=subject:fiction&maxResults=10&startIndex=0&langRestrict=en&key=AIzaSyDEitgO5m-K60ckaYJdjnC2xfOAQh3Pq7c")
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            if err == nil{
                
                guard let jsondata = data else { return }
                do{
                    self.results = try JSONDecoder().decode(BookResults.self, from: jsondata)
                    
                    DispatchQueue.main.async{
                        self.collectionView?.reloadData()
                        completed()
                    }
                }catch let error{
                    print(error)
                }
            }
            }.resume()
    }
    

}

