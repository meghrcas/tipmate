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
    // initialize a new Check variable to be used for each test
    override func setUp() {
        super.setUp()
        check = Check()
    }
    
    // deinitialize the Check variable after executing each test
    override func tearDown() {
        super.tearDown()
        check = nil
    }
    
    // test successful initialization of Check variables
    func testSuccessfulInit() {
        XCTAssertEqual(check.inputStr, "")
        XCTAssertEqual(check.subtotal, 0)
        XCTAssertEqual(check.percent, 15)
        XCTAssertEqual(check.tip, 0)
        XCTAssertEqual(check.total, 0)
    }
    
    // test setSubtotal Check function using valid and invalid inputStr values
    func testSetSubtotalFunc() {
        check.inputStr = "25.00"
        check.setSubtotal()
        XCTAssertEqual(check.subtotal, 25.00)
        check.inputStr = "..."
        check.setSubtotal()
        XCTAssertEqual(check.subtotal, 0)
    }
    
    // test getSubtotal Check function using a valid inputStr value
    func testGetSubtotalFunc() {
        check.inputStr = "25.00"
        check.setSubtotal()
        XCTAssertEqual(check.subtotal, 25)
        XCTAssertEqual(check.getSubtotal(), "$25.00")
    }
    
    // test getPercent Check function
    func testGetPercentFunc() {
        check.percent = 20
        XCTAssertEqual(check.getPercent(), "20%")
        XCTAssertEqual(check.percent, 20)
    }
    
    // test tip calculation using the getTip Check function
    func testGetTipFunc() {
        check.percent = 15
        check.subtotal = 25.00
        XCTAssertEqual(check.getTip(), "$3.75")
        XCTAssertEqual(check.tip, 3.75)
    }
    
    // test total calculation using the getTotal Check function
    func testGetTotalFunc() {
        check.subtotal = 25.00
        check.tip = 3.75
        XCTAssertEqual(check.getTotal(), "$28.75")
        XCTAssertEqual(check.total, 28.75)
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
    
    // test successful initialization of Check variables
    func testSuccessfulInit() {
        XCTAssertEqual(cv.check.inputStr, "")
        XCTAssertNoThrow(cv.check.setSubtotal())
        XCTAssertEqual(cv.check.getSubtotal(), "$0.00")
        XCTAssertEqual(cv.check.getPercent(), "15%")
        XCTAssertEqual(cv.check.getTip(), "$0.00")
        XCTAssertEqual(cv.check.getTotal(), "$0.00")
        XCTAssertFalse(cv.subtotalVisible)
    }
    
    // test invalid subtotal amount with default tip percentage
    func testInvalidInputStr() {
        cv.check.inputStr = "..."
        XCTAssertEqual(cv.check.inputStr, "...")
        XCTAssertNoThrow(cv.check.setSubtotal())
        XCTAssertEqual(cv.check.subtotal, 0.00)
        XCTAssertEqual(cv.check.getSubtotal(), "$0.00")
        XCTAssertEqual(cv.check.getPercent(), "15%")
        XCTAssertEqual(cv.check.getTip(), "$0.00")
        XCTAssertEqual(cv.check.getTotal(), "$0.00")
        XCTAssertFalse(cv.subtotalVisible)
    }
    
    // test valid subtotal amount with minimum tip percentage
    func testValidInputStrMinTipPercentage() {
        cv.check.inputStr = "50.00"
        cv.check.percent = 0
        XCTAssertNoThrow(cv.check.setSubtotal())
        XCTAssertEqual(cv.check.subtotal, 50.00)
        XCTAssertEqual(cv.check.getSubtotal(), "$50.00")
        XCTAssertEqual(cv.check.getPercent(), "0%")
        XCTAssertEqual(cv.check.getTip(), "$0.00")
        XCTAssertEqual(cv.check.getTotal(), "$50.00")
        XCTAssertTrue(cv.subtotalVisible)
    }
    
    // test nonzero subtotal amount with maximum tip percentage
    func testValidInputStrMaxTipPercentage() {
        cv.check.inputStr = "50.00"
        cv.check.percent = 100
        XCTAssertNoThrow(cv.check.setSubtotal())
        XCTAssertEqual(cv.check.subtotal, 50.00)
        XCTAssertEqual(cv.check.getSubtotal(), "$50.00")
        XCTAssertEqual(cv.check.getPercent(), "100%")
        XCTAssertEqual(cv.check.getTip(), "$50.00")
        XCTAssertEqual(cv.check.getTotal(), "$100.00")
        XCTAssertTrue(cv.subtotalVisible)
    }
    
    // test enterBtnTapped function
    func testEnterBtnTappedFunc() {
        XCTAssertNoThrow(cv.enterBtnTapped())
        XCTAssertNoThrow(cv.hideKeyboard())
    }
    
    // test inputStrEditedFunc
    func testInputStrEditedFunc() {
        XCTAssertNoThrow(cv.inputStrEdited())
        XCTAssertNoThrow(cv.check.setSubtotal())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
