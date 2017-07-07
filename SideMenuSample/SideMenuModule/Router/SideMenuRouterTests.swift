//
//  SideMenuRouterTests.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 30/06/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import XCTest
@testable import ViperSideDrawer
@testable import SideMenuSample

class SideMenuRouterTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIfStoryboardExists() {
        let path = getPathToStoryboard()
        XCTAssertNotNil(path, "Failed - could not find path for resource \(SideMenuRouter.storyboardName).storyboard")
    }

    func testIfViewControllerWithProperIDExists() {
        XCTAssert(viewControllerWithStoryboardIDExists(), "Failed - could not find ViewController with identifier \(SideMenuRouter.storyboardID) in \(SideMenuRouter.storyboardName).storyboard")
    }

    func testIfViewControllerIsOfProperType() {
        var assertion = false
        defer {
            XCTAssert(assertion, "ViewController with identifier \(SideMenuRouter.storyboardID) in \(SideMenuRouter.storyboardName).storyboard is not of type \(SideMenuRouter.viewControllerType)")
        }

        guard viewControllerWithStoryboardIDExists() else { return }
        let storyboard = getStoryboard()
        assertion = storyboard.instantiateViewController(withIdentifier: SideMenuRouter.storyboardID) is SideMenuViewController
    }

    func getPathToStoryboard() -> String? {
        return Bundle.main.path(forResource: SideMenuRouter.storyboardName, ofType: "storyboardc")
    }

    func getStoryboard() -> UIStoryboard {
        return UIStoryboard(name: SideMenuRouter.storyboardName, bundle: Bundle.main)
    }

    func viewControllerWithStoryboardIDExists(storyboardID: String = SideMenuRouter.storyboardID) -> Bool {
        guard getPathToStoryboard() != nil else { return false }
        let storyboard = getStoryboard()

        guard let storyboardValues = storyboard.value(forKey: "identifierToNibNameMap") as? [String : Any], (storyboardValues[storyboardID] != nil) else { return false }

        return true
    }

    func testViewInitialization() {
        let viewController = SideMenuRouter.instantiateModule()
        XCTAssertNotNil(viewController, "Failed with not initialized SideMenuViewController")
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
