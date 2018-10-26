//
//  WebViewController.swift
//  BookApp
//
//  Created by Mehul Padwal on 5/5/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    
    var url = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myWebView:UIWebView = UIWebView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        
        self.view.addSubview(myWebView)
        
        myWebView.delegate = self
        
        //1. Load web site into my web view
        let myURL = URL(string: url)
        let myURLRequest:URLRequest = URLRequest(url: myURL!)
        myWebView.loadRequest(myURLRequest)

        // Do any additional setup after loading the view.
    }

    
}
