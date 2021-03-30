//
//  ApiItemEntry.swift
//  Whitebook
//
//  Created by Vitor Marques de Miranda on 29/03/21.
//  Copyright © 2021 VitorMM. All rights reserved.
//

import Foundation

struct ApiItemEntry: Codable {
    var category: ApiItemEntryCategory
    var content: ApiItemEntryContent
    
    struct ApiItemEntryCategory: Codable {
        var id: Int
        var name: String
    }
    struct ApiItemEntryContent: Codable {
        var id: Int
        var name: String
        var urlImage: String
        var description: String
        var authors: [ApiItemEntryContentAuthor]
        
        struct ApiItemEntryContentAuthor: Codable {
            var name: String
        }
    }
}
