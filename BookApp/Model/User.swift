//
//  User.swift
//  ToDoListWithFirebase
//
//  Created by Mina Jung on 02/04/2018.
//  Copyright © 2018 Mina Jung. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: String?
    var name: String?
    var email: String?
    var fullname: String?
    var company: String?
    var work: String?
    var location: String?
    var profileurl: String?
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.fullname = dictionary["fullname"] as? String
        self.company = dictionary["company"] as? String
        self.work = dictionary["work"] as? String
        self.location = dictionary["location"] as? String
        self.profileurl = dictionary["profileurl"] as? String
    }
}
