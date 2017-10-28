//
//  XconeCLITests.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 28/10/2017.
//

import XCTest
@testable import Xcone

class XconeCLITests: XCTestCase {
  
  func testNoParameter() {
    // Declaration
    let sut = CommandLine(template: "", xcodeVersion: "", application: "", config: "")
    
    // Assertion
    XCTAssertNil(sut, "sut must to be nul because of no parameter is assign !")
  }

  func testMissingApplicationParameter() {
    // Expectation
    let expectation = CommandLineError.missingApplication
    
    // Declaration
    let sut1 = CommandLine(template: "banner", xcodeVersion: "", application: "", config: "")
    let sut2 = CommandLine(template: "banner", xcodeVersion: "9.0", application: "", config: "")
    let sut3 = CommandLine(template: "", xcodeVersion: "9.0", application: "", config: "")
    
    // Assertion
    XCTAssertNotNil(sut1, "sut1 must not be nil !")
    XCTAssertNotNil(sut2, "sut2 must not be nil !")
    XCTAssertNotNil(sut3, "sut3 must not be nil !")
    
    XCTAssertEqual(sut1!.error, expectation, "sut1 error must be missingApplication error not : \(sut1?.error?.description ?? "")")
    XCTAssertEqual(sut2!.error, expectation, "sut2 error must be missingApplication error not : \(sut2?.error?.description ?? "")")
    XCTAssertEqual(sut3!.error, expectation, "sut3 error must be missingApplication error not : \(sut3?.error?.description ?? "")")
  }

  func testConfigParamWithoutOtherParam() {
    // Expectation
    let expectation = CommandLineError.missingApplication
    
    // Declaration
    let sut = CommandLine(template: "", xcodeVersion: "", application: "", config: "config.yaml")
    
    // Assertion
    XCTAssertNotNil(sut, "sut must not be nil !")
    
    XCTAssertNotEqual(sut!.error, expectation, "no error must be apear, not : \(sut?.error?.description ?? "")")
  }
  
  func testConfigParamWithOtherParam() {
    // Expectation
    let expectation = CommandLineError.soMuchParams
    
    // Declaration
    let sut1 = CommandLine(template: "banner", xcodeVersion: "9.0", application: "Xcode", config: "config.yaml")
    let sut2 = CommandLine(template: "banner", xcodeVersion: "9.0", application: "", config: "config.yaml")
    let sut3 = CommandLine(template: "banner", xcodeVersion: "", application: "", config: "config.yaml")
    let sut4 = CommandLine(template: "", xcodeVersion: "9.0", application: "Xcode", config: "config.yaml")
    let sut5 = CommandLine(template: "", xcodeVersion: "", application: "Xcode", config: "config.yaml")
    
    // Assertion
    XCTAssertNotNil(sut1, "sut1 must not be nil !")
    XCTAssertNotNil(sut2, "sut2 must not be nil !")
    XCTAssertNotNil(sut3, "sut3 must not be nil !")
    XCTAssertNotNil(sut4, "sut4 must not be nil !")
    XCTAssertNotNil(sut5, "sut5 must not be nil !")
    
    XCTAssertEqual(sut1!.error, expectation, "sut1 error must be soMuchParams error not : \(sut1?.error?.description ?? "")")
    XCTAssertEqual(sut2!.error, expectation, "sut2 error must be soMuchParams error not : \(sut2?.error?.description ?? "")")
    XCTAssertEqual(sut3!.error, expectation, "sut3 error must be soMuchParams error not : \(sut3?.error?.description ?? "")")
    XCTAssertEqual(sut4!.error, expectation, "sut4 error must be soMuchParams error not : \(sut4?.error?.description ?? "")")
    XCTAssertEqual(sut5!.error, expectation, "sut5 error must be soMuchParams error not : \(sut5?.error?.description ?? "")")
  }
}

extension XconeCLITests {
  static var allTests : [(String, (XconeCLITests) -> () throws -> Void)] {
    return [
      ("testNoParameter", testNoParameter),
      ("testMissingApplicationParameter", testMissingApplicationParameter),
      ("testConfigParamWithoutOtherParam", testConfigParamWithoutOtherParam),
      ("testConfigParamWithOtherParam", testConfigParamWithOtherParam)
    ]
  }
}
