//
//  tipmateUITests.swift
//  tipmateUITests
//
//  Created by Meghan Castro on 11/19/20.
//

import XCTest
@testable import tipmate

class tipmateUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }
    
    // test subtotal amount "50.00" with default tip percentage
    func testTextFieldBehaviors() throws {
        let expectedTipStr = "$7.50"
        let expectedTotalStr = "$57.50"
        let expectedSubtotalStr = "$50.00"
        let subtotalField = app.textFields.element//["enter the subtotal amount in USD"]
        XCTAssertFalse(app.buttons["enter"].isEnabled)
        subtotalField.tap()
        XCTAssert(subtotalField.exists)
        XCTAssert(subtotalField.label.isEmpty)
        XCTAssert(app.buttons["enter"].isEnabled)
        subtotalField.typeText("50.00")
        app.buttons["enter"].tap()
        XCTAssertFalse(app.buttons["enter"].isEnabled)
        XCTAssert(subtotalField.label.isEmpty)
        XCTAssertFalse(subtotalField.isSelected)
        XCTAssert(app.staticTexts[expectedTipStr].isHittable)
        XCTAssert(app.staticTexts[expectedTotalStr].isHittable)
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
