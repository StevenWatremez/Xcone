//
//  SerializationService.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 29/10/2017.
//

import Foundation
import Files

internal struct FileSystem {
  
 func findApplication(byPath path: String) -> Path? {
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
  
  func findApplication(byName name: String) -> Path? {
    // search Xcode application with name inside applications folder
    let usableName = name.contains(".app") ? name : name + ".app"
    let applicationFolderName = "/Applications"
    let applicationFolder = try? Folder(path: applicationFolderName)
    let hasXcode = applicationFolder?.containsSubfolder(named: usableName) ?? false
    let rPath: Path = applicationFolderName + "/" + usableName + "/Contents"
    return hasXcode ? rPath : nil
  }
}
