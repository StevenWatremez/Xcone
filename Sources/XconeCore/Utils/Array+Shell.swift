//
//  Array+Shell.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 02/11/2017.
//

import Foundation

extension Array where Element == String {
  mutating func append(shellElement: String) {
    append(" " + shellElement)
  }
  
  /// Use shell to exec command line. Usage :
  ///
  /// * shell("ls")
  /// * shell("xcodebuild", "-workspace", "myApp.xcworkspace")
  ///
  /// - Parameter args: all separate arguments to exec command line
  /// - Returns: termination status
  @discardableResult
  func shellExec() -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = self
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
  }
}
