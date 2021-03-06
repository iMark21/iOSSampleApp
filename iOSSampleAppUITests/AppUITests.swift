//
//  iOSSampleAppUITests.swift
//  iOSSampleAppUITests
//
//  Created by Igor Kulman on 23/03/2018.
//  Copyright © 2018 Igor Kulman. All rights reserved.
//

import SimulatorStatusMagiciOS
import XCTest

class AppUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        XCUIDevice.shared.orientation = .portrait
        setupSnapshot(app)
        app.launchArguments += ["testMode"]
        app.launch()

        #if DEBUG
            SDStatusBarManager.sharedInstance().carrierName = ""
            SDStatusBarManager.sharedInstance().timeString = "9:41"
            SDStatusBarManager.sharedInstance().bluetoothState = .hidden
            SDStatusBarManager.sharedInstance().batteryDetailEnabled = true
            SDStatusBarManager.sharedInstance().networkType = .typeWiFi
            SDStatusBarManager.sharedInstance().enableOverrides()
        #endif

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()

        #if DEBUG
            SDStatusBarManager.sharedInstance().disableOverrides()
        #endif
    }

    func testScreenshots() {
        snapshot("1-Setup")

        app.tables.cells.element(boundBy: 0).tap()
        app.buttons["done"].tap()

        snapshot("2-List")

        app.tables.cells.element(boundBy: 0).tap()
        let home = app.links["Igor Kulman"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: home, handler: nil)

        waitForExpectations(timeout: 5, handler: nil)

        snapshot("3-Detail")

        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.buttons["about"].tap()

        snapshot("4-About")
    }
}
