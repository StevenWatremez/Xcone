//
//  Params.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 29/10/2017.
//

import Foundation

public struct Params {
  let template: String
  let xcodeVersion: String?
  let application: String
  
  public init(template: String?, xcodeVersion: String?, application: String) {
    self.template = template ?? "banner"
    self.xcodeVersion = xcodeVersion
    self.application = application
  }
}
