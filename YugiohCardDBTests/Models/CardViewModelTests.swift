//
//  CardViewModelTests.swift
//  YugiohCardDBTests
//
//  Created by bhrs on 11/2/21.
//

import XCTest
@testable import YugiohCardDB
@testable import YGOPRODeckClient

class CardViewModelTests: XCTestCase {
    func testEmptyViewModelValues() throws {
        let cardViewModel = CardViewModel()
        XCTAssertEqual(cardViewModel.id, "0")
        XCTAssertEqual(cardViewModel.name, "")
        XCTAssertEqual(cardViewModel.searchName, "")
        XCTAssertEqual(cardViewModel.imageUrl, "")
        XCTAssertEqual(cardViewModel.imageUrlSmall, "")
        XCTAssertEqual(cardViewModel.type, .unknown)
        XCTAssertEqual(cardViewModel.displayTypeName, "")
        XCTAssertEqual(cardViewModel.description, "")
    }
    
    func testViewModelWithValues() throws {
        let cardViewModel = CardViewModel()
        XCTAssertEqual(cardViewModel.id, "0")
        XCTAssertEqual(cardViewModel.name, "")
        XCTAssertEqual(cardViewModel.searchName, "")
        XCTAssertEqual(cardViewModel.imageUrl, "")
        XCTAssertEqual(cardViewModel.imageUrlSmall, "")
        XCTAssertEqual(cardViewModel.type, .unknown)
        XCTAssertEqual(cardViewModel.displayTypeName, "")
        XCTAssertEqual(cardViewModel.description, "")
    }
}
