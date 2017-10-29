//
//  XcodeVersionPlist.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 29/10/2017.
//

import Foundation

internal struct XcodeVersionPlist: Codable {
  var version: String
  
  private enum CodingKeys: String, CodingKey {
    case version = "CFBundleShortVersionString"
  }
}
