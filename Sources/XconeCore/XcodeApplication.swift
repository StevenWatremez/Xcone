//
//  XcodeApplication.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 29/10/2017.
//

import Foundation
import Files

/// Engine to search Xcode application from param --application
public struct XcodeApplication {
  
  /// --application param from cli
  private let application: String
  private let xcodeVersion: String?
  private let serialization: SerializationService
  private let fileSystem: FileSystem
  
  init(application: String, xcodeVersion: String? = nil, serialization: SerializationService, fileSystem: FileSystem) {
    self.application = application
    self.serialization = serialization
    self.xcodeVersion = xcodeVersion
    self.fileSystem = fileSystem
  }
  
  /// Detail object to manipulate xcode datas
  var detail: XcodeDetail? {
    guard let path = self.path,
      let version: String = (self.xcodeVersion != nil) ? self.xcodeVersion : self.version(path: path),
      let iconName = self.iconName(path: path) else {
        return nil
    }
    let xcodeDetail = XcodeDetail(path: path, version: version, iconName: iconName)
    return xcodeDetail
  }
  
  /// Path to the found Xcode application
  private var path: Path? {
    var rPath: Path?
    if self.application.isPath() {
      rPath = self.fileSystem.findApplication(byPath: self.application)
    } else {
      rPath = self.fileSystem.findApplication(byName: self.application)
    }
    return rPath
  }
  
  private func version(path: Path) -> String? {
    let xcodeVersionPlist: XcodeVersionPlist? = self.serialization.parse(path: path, fileName: "version.plist")
    return xcodeVersionPlist?.version
  }
  
  private func iconName(path: Path) -> String? {
    let xcodeInfoPlist: XcodeInfoPlist? = self.serialization.parse(path: path, fileName: "info.plist")
    return xcodeInfoPlist?.iconName
  }
  
  /// Test if path to Xcode application exists
  ///
  /// - Parameter path: path to supposed Xcode application
  /// - Returns: boolean if path to Xcode application exists
  private func exists(path: Path) -> Bool {
    return true
  }
}
