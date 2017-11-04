//
//  XcodeDetail.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 29/10/2017.
//

import Foundation

struct XcodeDetail {
  //var name: String = ""
  let rootPath: String
  let contentsPath: String
  let resourcesPath: String
  let version: String
  let iconName: String
}

extension XcodeDetail: CustomStringConvertible {
  var description: String {
    return "XcodeDetail :: rootPath = '\(self.rootPath)', version = '\(self.version)', iconName = '\(self.iconName)'"
  }
}
