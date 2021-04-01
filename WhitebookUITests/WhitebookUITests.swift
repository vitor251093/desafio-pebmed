//
//  WhitebookUITests.swift
//  WhitebookUITests
//
//  Created by Vitor Marques de Miranda on 29/03/21.
//  Copyright © 2021 VitorMM. All rights reserved.
//

import XCTest

class WhitebookUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUI() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchEnvironment = ["json":"""
            [{
                "category": {"id": 1, "name": "category"},
                "content": {
                    "id": 2,
                    "name": "item",
                    "urlImage": "https://picsum.photos/id/703/400/300",
                    "description": "abc",
                    "authors": [{"name": "x"}]
                }
            }]
        """]
        app.launch()

        app.tables.cells.firstMatch.tap()
        
        XCTAssertEqual(app.staticTexts["name"].label, "item")
        XCTAssertEqual(app.staticTexts["description"].label, "abc")
        XCTAssertEqual(app.staticTexts["authors"].label, "Autores: x")
    }
}
