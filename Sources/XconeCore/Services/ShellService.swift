//
//  ShellService.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 01/11/2017.
//

import Foundation

/// Service to manipulate shell
internal struct ShellService {
  /// Use shell to exec command line. Usage :
  ///
  /// * shell("ls")
  /// * shell("xcodebuild", "-workspace", "myApp.xcworkspace")
  ///
  /// - Parameter args: all separate arguments to exec command line
  /// - Returns: termination status
  @discardableResult
  func shell(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
  }
}
