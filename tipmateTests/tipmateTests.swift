//
//  tipmateTests.swift
//  tipmateTests
//
//  Created by Meghan Castro on 11/19/20.
//

import XCTest
@testable import tipmate

class CheckUnitTests: XCTestCase {
    var check: Check!
    
    override func setUp() {
        super.setUp()
        check = Check()
    }
    
    override func tearDown() {
        super.tearDown()
        check = nil
    }
    
    func testFailedInit() {
        check = nil
        XCTAssertNil(check)
    }
    
    func testSuccessfulInit() {
        XCTAssertNotNil(check)
        XCTAssertEqual(check.inputStr, "")
        XCTAssertEqual(check.subtotal, 0)
        XCTAssertEqual(check.percent, 15)
        XCTAssertEqual(check.tip, 0)
        XCTAssertEqual(check.total, 0)
    }
    
    func testSetSubtotalFunc() {
        XCTAssertNotNil(check)
        XCTAssertEqual(check.inputStr, "")
        XCTAssertEqual(check.subtotal, 0)

        check.inputStr = "25.00"
        check.setSubtotal()
        XCTAssertEqual(check.subtotal, 25.00)

        check.inputStr = "..."
        check.setSubtotal()
        XCTAssertEqual(check.subtotal, 0)
    }
    
    func testGetSubtotalFunc() {
        XCTAssertNotNil(check)
        XCTAssertEqual(check.subtotal, 0)
        XCTAssertEqual(check.getSubtotal(), "$0.00")
        check.inputStr = "25.00"
        check.setSubtotal()
        XCTAssertEqual(check.subtotal, 25)
        XCTAssertEqual(check.getSubtotal(), "$25.00")
    }
    
    func testGetTipFunc() {
        XCTAssertNotNil(check)
        XCTAssertEqual(check.getTip(), "$0.00")
        XCTAssertEqual(check.tip, 0)

        check.percent = 15
        check.subtotal = 25.00

        XCTAssertEqual(check.getTip(), "$3.75")
        XCTAssertEqual(check.tip, 3.75)
    }
    
    func testGetTotalFunc() {
        XCTAssertNotNil(check)
        XCTAssertEqual(check.getTotal(), "$0.00")
        XCTAssertEqual(check.total, 0)

        check.subtotal = 25.00
        check.tip = 3.75

        XCTAssertEqual(check.getTotal(), "$28.75")
        XCTAssertEqual(check.total, 28.75)
    }
    
    func testGetPercentFunc() {
        XCTAssertNotNil(check)
        XCTAssertEqual(check.getPercent(), "15%")
        XCTAssertEqual(check.percent, 15)

        check.percent = 20

        XCTAssertEqual(check.getPercent(), "20%")
        XCTAssertEqual(check.percent, 20)
    }
}

class tipmateIntegrationTests: XCTestCase {
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
    
    // test setSubtotal function
    func testSetSubtotalFunc() throws {
        XCTAssertEqual(cv.check.inputStr, "")
        XCTAssertFalse(cv.subtotalVisible)

        cv.check.inputStr = "50.00"
        XCTAssertEqual(cv.check.inputStr, "50.00")
        cv.check.setSubtotal()
        XCTAssertEqual(cv.check.subtotal, 50)
        XCTAssertTrue(cv.subtotalVisible)
    }
    
    // test getSubtotal function
    func testGetSubtotalFunc() {
        XCTAssertEqual(cv.check.getSubtotal(), "$0.00")
        cv.check.subtotal = 50.00
        XCTAssertEqual(cv.check.getSubtotal(), "$50.00")
        XCTAssertTrue(cv.subtotalVisible)

    }
    
    // test default subtotal and tip percentage values
    func testDefaultValues() {
        XCTAssertEqual(cv.check.inputStr, "")
        XCTAssertEqual(cv.check.getSubtotal(), "$0.00")
        XCTAssertEqual(cv.check.getPercent(), "15%")
        XCTAssertEqual(cv.check.getTip(), "$0.00")
        XCTAssertEqual(cv.check.getTotal(), "$0.00")
        XCTAssertFalse(cv.subtotalVisible)
    }
    
    // test valid subtotal amount with default tip percentage
    func testValidInputStr() throws {
        cv.check.inputStr = "50.00"
        cv.check.setSubtotal()
        XCTAssertEqual(cv.check.getSubtotal(), "$50.00")
        XCTAssertEqual(cv.check.getPercent(), "15%")
        XCTAssertEqual(cv.check.getTip(), "$7.50")
        XCTAssertEqual(cv.check.getTotal(), "$57.50")
        XCTAssertTrue(cv.subtotalVisible)
    }
    
    // test valid subtotal amount with default tip percentage
    func testInvalidInputStr() throws {
        cv.check.inputStr = "..."
        cv.check.setSubtotal()
        XCTAssertEqual(cv.check.getSubtotal(), "$0.00")
        XCTAssertEqual(cv.check.getPercent(), "15%")
        XCTAssertEqual(cv.check.getTip(), "$0.00")
        XCTAssertEqual(cv.check.getTotal(), "$0.00")
        XCTAssertFalse(cv.subtotalVisible)
    }
    
    // test valid subtotal amount with minimum tip percentage
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
