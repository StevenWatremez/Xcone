//
//  XcodeDetail.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 29/10/2017.
//

import Foundation

struct XcodeDetail {
  //var name: String = ""
  let path: String
  let version: String
  let iconName: String
}

extension XcodeDetail: CustomStringConvertible {
  var description: String {
    return "XcodeDetail :: path = '\(self.path)', version = '\(self.version)', iconName = '\(self.iconName)'"
  }
}
