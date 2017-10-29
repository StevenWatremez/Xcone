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
  
  init(application: String, xcodeVersion: String? = nil, serialization: SerializationService) {
    self.application = application
    self.serialization = serialization
    self.xcodeVersion = xcodeVersion
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
      rPath = self.findByPath(path: self.application)
    } else {
      rPath = self.findByName(name: self.application)
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

extension XcodeApplication {
  private func findByPath(path: String) -> Path? {
    // search Xcode application with path
    var usablePath = path.contains(".app") ? path : path + ".app"
    usablePath += "/Contents"
    let versionFileName = "version.plist"
    let infoFileName = "info.plist"
    guard let contentsFolder = try? Folder(path: usablePath),
      contentsFolder.containsFile(named: versionFileName),
      contentsFolder.containsFile(named: infoFileName) else {
        return nil
    }
    return usablePath
  }
  
  private func findByName(name: String) -> Path? {
    // search Xcode application with name inside applications folder
    let usableName = name.contains(".app") ? name : name + ".app"
    let applicationFolderName = "/Applications"
    let applicationFolder = try? Folder(path: applicationFolderName)
    let hasXcode = applicationFolder?.containsSubfolder(named: usableName) ?? false
    let rPath: Path = applicationFolderName + "/" + usableName + "/Contents"
    return hasXcode ? rPath : nil
  }
}
