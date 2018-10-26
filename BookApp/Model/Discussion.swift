//
//  Discussion.swift
//  BookApp
//
//  Created by Mehul Padwal on 5/4/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import Foundation


class Discussion : NSObject {
    var  discId : String?
    var title : String?
    var selfLink : String?
    var bookName : String?
    var discussion : String?
    var likes : Int?
    var name : String?
    var profileImage : String?
    var peopleWhoLike: [String] = [String]()
}
