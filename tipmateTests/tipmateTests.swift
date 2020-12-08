//
//  tipmateTests.swift
//  tipmateTests
//
//  Created by Meghan Castro on 11/19/20.
//

import XCTest
@testable import tipmate

class tipmateTests: XCTestCase {
    var cv: ContentView!
    
    // instantiate new ContentView variable before each test
    override func setUp() {
        super.setUp()
        cv = ContentView()
    }
    
    // reset state of cv variable after each test
    override func tearDown() {
        super.tearDown()
        cv = nil
    }
    
    // test default subtotal and tip percentage values
    func testDefaultValues() {
        XCTAssertEqual(cv.check.getSubtotal(), "$0.00")
        XCTAssertEqual(cv.check.getPercent(), "15%")
        XCTAssertEqual(cv.check.getTip(), "$0.00")
        XCTAssertEqual(cv.check.getTotal(), "$0.00")
        XCTAssertFalse(cv.subtotalVisible)
    }
    
    // test nonzero subtotal amount with default tip percentage
    func testValidSubtotal() throws {
        cv.check.subtotal = 50.00
        cv.check.percent = 15
        XCTAssertEqual(cv.check.getSubtotal(), "$50.00")
        XCTAssertEqual(cv.check.getPercent(), "15%")
        XCTAssertEqual(cv.check.getTip(), "$7.50")
        XCTAssertEqual(cv.check.getTotal(), "$57.50")
        XCTAssertTrue(cv.subtotalVisible)
    }
    
    // test nonzero subtotal amount with minimum tip percentage
    func testMinTipPercentage() {
        cv.check.subtotal = 50.00
        cv.check.percent = 0
        XCTAssertEqual(cv.check.getSubtotal(), "$50.00")
        XCTAssertEqual(cv.check.getPercent(), "0%")
        XCTAssertEqual(cv.check.getTip(), "$0.00")
        XCTAssertEqual(cv.check.getTotal(), "$50.00")
        XCTAssertTrue(cv.subtotalVisible)
    }
    
    // test nonzero subtotal amount with maximum tip percentage
    func testMaxTipPercentage() {
        cv.check.subtotal = 50.00
        cv.check.percent = 100
        XCTAssertEqual(cv.check.getSubtotal(), "$50.00")
        XCTAssertEqual(cv.check.getPercent(), "100%")
        XCTAssertEqual(cv.check.getTip(), "$50.00")
        XCTAssertEqual(cv.check.getTotal(), "$100.00")
        XCTAssertTrue(cv.subtotalVisible)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
