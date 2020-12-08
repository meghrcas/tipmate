//
//  tipmateUITests.swift
//  tipmateUITests
//
//  Created by Meghan Castro on 11/19/20.
//

import XCTest
var app: XCUIApplication!

class tipmateUITests: XCTestCase {

    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // test subtotal amount "50.00" with default tip percentage
    func testTextField() throws {
        let expectedTipStr = "$7.50"
        let expectedTotalStr = "$57.50"
        let expectedSubtotalStr = "$50.00"
        let subtotalField = app.textFields["enter the subtotal amount in USD"]
        //XCTAssertFalse(app.staticTexts["subtotal: "].//textColor)
        XCTAssertFalse(app.buttons["enter"].isEnabled)
        subtotalField.tap()
        XCTAssert(app.buttons["enter"].isEnabled)
        subtotalField.typeText("50.00")
        app.buttons["enter"].tap()
        XCTAssertFalse(app.buttons["enter"].isEnabled)
        XCTAssert(app.staticTexts[expectedTipStr].isHittable)
        XCTAssert(app.staticTexts[expectedTotalStr].isHittable)
        //XCTAssert(app.staticTexts["subtotal: "].isHittable)
        XCTAssert(app.staticTexts[expectedSubtotalStr].isHittable)
    }
    
    // test slider functionality using the minimum and maximum values
    func testSlider() throws {
        XCTAssert(app.staticTexts["15%"].isHittable)
        app.sliders["0.15"].adjust(toNormalizedSliderPosition: 0)
        XCTAssert(app.staticTexts["0%"].isHittable)
        app.sliders["0"].adjust(toNormalizedSliderPosition: 1)
        XCTAssert(app.staticTexts["100%"].isHittable)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
