//
//  MainOption2RouterTests.swift
//  ViperSideDrawer
//
//  Created by Aleksander Maj on 07/07/2017.
//  Copyright © 2017 Aleksander Maj. All rights reserved.
//

import XCTest
@testable import SideMenuSample

class MainOption2RouterTests: XCTestCase {

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
        XCTAssertNotNil(path, "Failed - could not find path for resource \(MainOption2Router.storyboardName).storyboard")
    }

    func testIfViewControllerWithProperIDExists() {
        XCTAssert(viewControllerWithStoryboardIDExists(), "Failed - could not find ViewController with identifier \(MainOption2Router.storyboardID) in \(MainOption2Router.storyboardName).storyboard")
    }

    func testIfViewControllerIsOfProperType() {
        var assertion = false
        defer {
            XCTAssert(assertion, "ViewController with identifier \(MainOption2Router.storyboardID) in \(MainOption2Router.storyboardName).storyboard is not of type \(MainOption2Router.viewControllerType)")
        }

        guard viewControllerWithStoryboardIDExists() else { return }
        let storyboard = getStoryboard()
        assertion = storyboard.instantiateViewController(withIdentifier: MainOption2Router.storyboardID) is MainOption2ViewController
    }

    func getPathToStoryboard() -> String? {
        return Bundle.main.path(forResource: MainOption2Router.storyboardName, ofType: "storyboardc")
    }

    func getStoryboard() -> UIStoryboard {
        return UIStoryboard(name: MainOption2Router.storyboardName, bundle: Bundle.main)
    }

    func viewControllerWithStoryboardIDExists(storyboardID: String = MainOption2Router.storyboardID) -> Bool {
        guard getPathToStoryboard() != nil else { return false }
        let storyboard = getStoryboard()

        guard let storyboardValues = storyboard.value(forKey: "identifierToNibNameMap") as? [String : Any], (storyboardValues[storyboardID] != nil) else { return false }

        return true
    }

    func testViewInitialization() {
        let viewController = MainOption2Router.instantiateModule()
        XCTAssertNotNil(viewController, "Failed with not initialized MainOption2ViewController")
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
