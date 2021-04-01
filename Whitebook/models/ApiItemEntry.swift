//
//  ApiItemEntry.swift
//  Whitebook
//
//  Created by Vitor Marques de Miranda on 29/03/21.
//  Copyright © 2021 VitorMM. All rights reserved.
//

import Foundation

struct ApiItemEntry: Codable, Equatable {
    var category: ApiItemEntryCategory
    var content: CategoryItem
    
    struct ApiItemEntryCategory: Codable, Equatable {
        var id: Int
        var name: String
    }
}
