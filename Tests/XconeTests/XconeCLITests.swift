//
//  XconeCLITests.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 28/10/2017.
//

import XCTest
@testable import XconeCore

class XconeCLITests: XCTestCase {
  func testNoParameter() {

  }

  func testMissingApplicationParameter() {
    
  }

  func testConfigParamWithoutOtherParam() {
    
  }
  
  func testConfigParamWithOtherParam() {
    
  }
}

extension XconeCLITests {
  static var allTests: [(String, (XconeCLITests) -> () throws -> Void)] {
    return [
      ("testNoParameter", testNoParameter),
      ("testMissingApplicationParameter", testMissingApplicationParameter),
      ("testConfigParamWithoutOtherParam", testConfigParamWithoutOtherParam),
      ("testConfigParamWithOtherParam", testConfigParamWithOtherParam)
    ]
  }
}
