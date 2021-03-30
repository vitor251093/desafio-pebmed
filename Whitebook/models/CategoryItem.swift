//
//  CategoryItem.swift
//  Whitebook
//
//  Created by Vitor Marques de Miranda on 29/03/21.
//  Copyright © 2021 VitorMM. All rights reserved.
//

import Foundation

struct CategoryItem {
    var id: Int
    var name: String
    var urlImage: String
    var description: String
    var authors: [CategoryItemAuthor]
}
