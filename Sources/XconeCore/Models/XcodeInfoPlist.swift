//
//  XcodeInfoPlist.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 29/10/2017.
//

import Foundation

internal struct XcodeInfoPlist: Codable {
  var iconName: String
  private enum CodingKeys: String, CodingKey {
    case iconName = "CFBundleIconFile"
  }
}
