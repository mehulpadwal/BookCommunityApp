//
//  BookDetails.swift
//  BookApp
//
//  Created by Mehul Padwal on 4/27/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import UIKit


class BookDetailCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var previewLink : String?
    var navController : UICollectionViewController?
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "background")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let bookName : UILabel = {
        let text = UILabel()
        text.text = "Book"
        text.numberOfLines = 2
        text.textColor = UIColor(r: 0, g: 166, b: 166)
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let publisher : UILabel = {
        let text = UILabel()
        text.text = "Publisher"
        text.numberOfLines = 2
        text.textColor = UIColor(r: 0, g: 166, b: 166)
        text.font = UIFont.systemFont(ofSize: 14)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let previewButton : UIButton = {
        let button = UIButton()
        button.setTitle("More Info", for: .normal)
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let seprator : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
        
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionText : UILabel = {
        let text = UILabel()
        text.textColor = UIColor(r: 0, g: 166, b: 166)
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 14)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    func setupViews(){
        addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 128).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 206).isActive = true
        
        addSubview(bookName)
        
        bookName.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        bookName.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 12).isActive = true
        bookName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
       
        addSubview(publisher)
        
        publisher.topAnchor.constraint(equalTo: bookName.bottomAnchor, constant: 3).isActive = true
        publisher.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 12).isActive = true
        publisher.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        addSubview(previewButton)
        
        previewButton.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 12).isActive = true
        previewButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant : -8).isActive = true
        previewButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        previewButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        previewButton.addTarget(self, action: #selector(showPreview), for: .touchUpInside)
        
        addSubview(seprator)
        
        seprator.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        seprator.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        seprator.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 5).isActive = true
        seprator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        addSubview(descriptionLabel)
        
        descriptionLabel.topAnchor.constraint(equalTo: seprator.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        addSubview(descriptionText)
        
        descriptionText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true
        descriptionText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        descriptionText.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -8).isActive = true
        
    }
    
    
    @objc func showPreview(){
        let webView = WebViewController()
        webView.url = previewLink!
        navController?.navigationController?.pushViewController(webView, animated: true)
    }
    
}
