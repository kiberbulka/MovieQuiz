//
//  MovieQuizUITest.swift
//  MovieQuizUITest
//
//  Created by Olya on 13.10.2024.
//


import XCTest

final class MovieQuizUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.terminate()
        app = nil
    }
    func testScreenCast() throws {
        
    }
}

