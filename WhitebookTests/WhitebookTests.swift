//
//  WhitebookTests.swift
//  WhitebookTests
//
//  Created by Vitor Marques de Miranda on 29/03/21.
//  Copyright © 2021 VitorMM. All rights reserved.
//

import XCTest
@testable import Whitebook

class WhitebookTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListFromApiList() throws {
        let controller = CategoriesViewController()
        
        let categoryId = 1
        let categoryName = "category"
        let itemId = 2
        let itemName = "item"
        let itemUrlImage = "www.google.com"
        let itemDescription = "abc"
        let itemAuthorName = "x"
        
        let input = ApiItemEntry.init(
            category: ApiItemEntry.ApiItemEntryCategory.init(
                id: categoryId,
                name: categoryName
            ),
            content: CategoryItem.init(
                id: itemId,
                name: itemName,
                urlImage: itemUrlImage,
                description: itemDescription,
                authors: [CategoryItemAuthor.init(name: itemAuthorName)])
        )
        let expectedOutput = [Category.init(
            id: categoryId,
            name: categoryName,
            items: [CategoryItem.init(
                id: itemId,
                name: itemName,
                urlImage: itemUrlImage,
                description: itemDescription,
                authors: [CategoryItemAuthor.init(name: itemAuthorName)])]
        )]
        
        let output = controller.listFromApiList([input])
        XCTAssertEqual(output, expectedOutput)
    }
}
