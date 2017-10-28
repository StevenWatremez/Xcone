//
//  XconeTests.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 28/10/2017.
//

import XCTest

class XconeTests: XCTestCase {
  func testTemplate() {
    //XCTAssertEqual(Country(code: "AT").emojiFlag, "\u{1f1e6}\u{1f1f9}")
  }

  func testVersion() {
    //XCTAssertEqual(Country(code: "TR").emojiFlag, "\u{1f1f9}\u{1f1f7}")
  }

  func testAuto() {
    //XCTAssertEqual(Country(code: "US").emojiFlag, "\u{1f1fa}\u{1f1f8}")
  }
}

extension XconeTests {
  static var allTests : [(String, (XconeTests) -> () throws -> Void)] {
    return [
      ("testTemplate", testTemplate),
      ("testVersion", testVersion),
      ("testAuto", testAuto)
    ]
  }
}
