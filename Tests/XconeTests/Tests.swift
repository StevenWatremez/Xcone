//
//  Tests.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 28/10/2017.
//

import XCTest
import XconeKit

class Tests: XCTestCase {
  
  func testNil() {
    let error = CommandLineError.missingApplication
    print("\(error.description)")
    XCTAssertNil(nil, "element must be nil !")
  }
}
