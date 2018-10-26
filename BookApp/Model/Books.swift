//
//  Books.swift
//  BookApp
//
//  Created by Mehul Padwal on 4/26/18.
//  Copyright © 2018 Mehul Padwal. All rights reserved.
//

import Foundation
import UIKit


struct BookResults : Decodable{
    
    let totalItems : Int?
    let items : [BookInfo]
    
}


struct BookInfo {
    
    enum RootKeys : String ,CodingKey {
        case id ,selfLink, volumeInfo
    }
    
    enum BookKeys : String , CodingKey {
        case title , publisher , imageLinks , description , infoLink
    }
    
    enum Images : String , CodingKey {
        case thumbnail
    }
    
    
    let id : String
    let title : String
    let publisher : String
    let thumbnail : String
    let selfLink : String
    let description : String
    let infoLink : String

    
}

extension BookInfo : Decodable {
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: RootKeys.self)
        id = try container.decode(String.self, forKey: .id)
        selfLink = try container.decode(String.self, forKey: .selfLink)
        
        
        let userContainer = try container.nestedContainer(keyedBy: BookKeys.self, forKey: .volumeInfo)
        title = try userContainer.decode(String.self, forKey: .title)
        publisher = try userContainer.decode(String.self, forKey: .publisher)
        description = try userContainer.decode(String.self, forKey: .description)
        infoLink = try userContainer.decode(String.self, forKey: .infoLink)
        
        
        let imagecontainer = try userContainer.nestedContainer(keyedBy: Images.self, forKey: .imageLinks)
        thumbnail = try imagecontainer.decode(String.self, forKey: .thumbnail)

    }
}


//struct RawResponse : Decodable{
//    var totalItems : Int
//    var items : [Book]
//
//    struct Book : Decodable {
//        var id : String
//        var volumeInfo : BookInfo
//
//
//
//        struct BookInfo : Decodable {
//            var title : String
//            var publisher : String
//            var description: String
//
//            var insdustryIdentfiers : [isbnidentifiers]
//
//            struct isbnidentifiers : Decodable {
//                var identifiers : String
//            }
//
//        }
//
//    }
//}
//
//
//
//struct ServerResponse : Decodable{
//    var totalItems : Int
//    var id : String
//    var title: String
//    var description : String
//    var identifiers : String
//    init(from decoder: Decoder) throws{
//        let rawResponse = try RawResponse(from: decoder)
//
//        totalItems = Int(rawResponse.totalItems)
//        id = String(rawResponse.items.first!.id)
//        title = rawResponse.items.first!.volumeInfo.title
//        description = rawResponse.items.first!.volumeInfo.description
//        identifiers = rawResponse.items.first!.volumeInfo.insdustryIdentfiers.first!.identifiers
//
//    }
//
//
//
//}

