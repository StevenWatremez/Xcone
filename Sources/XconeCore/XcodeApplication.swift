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
  typealias Path = String
  
  /// --application param from cli
  private let application: String
  var detail: XcodeDetail? {
    guard let path = self.path,
      let version = self.version(path: path),
      let iconName = self.iconName(path: path) else {
        return nil
    }
    let xcodeDetail = XcodeDetail(path: path, version: version, iconName: iconName)
    return xcodeDetail
  }
  
  public init(application: String) {
    self.application = application
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
  
  func version(path: Path) -> String? {
    let versionPlistFile = try? Folder(path: path + "/" + "Contents").file(named: "version.plist")
    
    if let data = try? versionPlistFile?.read() {
      let decoder = PropertyListDecoder()
      let settings = try? decoder.decode(XcodeVersionPlist.self, from: data!)
      return settings?.version
    }
    return nil
  }
  
  func iconName(path: Path) -> String? {
    let iconPlistFile = try? Folder(path: path + "/" + "Contents").file(named: "info.plist")
    
    if let data = try? iconPlistFile?.read() {
      let decoder = PropertyListDecoder()
      let settings = try? decoder.decode(XcodeInfoPlist.self, from: data!)
      return settings?.iconName
    }
    return nil
  }
  
  private func findByPath(path: String) -> Path? {
    // check if path contain :
    // - /Contents
    // - /Contents/version.plist
    // - /Contents/info.plist
    let usablePath = path.contains(".app") ? path : path + ".app"
    let subFolderName = "Contents"
    let versionFileName = "version.plist"
    let infoFileName = "info.plist"
    guard let folder = try? Folder(path: usablePath),
      folder.containsSubfolder(named: subFolderName),
      let contentsFolder = try? Folder(path: usablePath + "/" + subFolderName),
      contentsFolder.containsFile(named: versionFileName),
      contentsFolder.containsFile(named: infoFileName) else {
        return nil
    }
    return usablePath
  }
  
  private func findByName(name: String) -> Path? {
    // search Xcode application with name inside
    return nil
  }
  
  /// Test if path to Xcode application exists
  ///
  /// - Parameter path: path to supposed Xcode application
  /// - Returns: boolean if path to Xcode application exists
  private func exists(path: Path) -> Bool {
    return true
  }
}
