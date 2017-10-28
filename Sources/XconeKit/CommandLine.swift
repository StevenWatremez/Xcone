//
//  Command.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 28/10/2017.
//

import Foundation

public class CommandLine {
  let template: String?
  let xcodeVersion: String?
  let application: String?
  let config: String?
  
  public init(template: String,
       xcodeVersion: String,
       application: String,
       config: String) {
    // guard !template.isEmpty || !xcodeVersion.isEmpty || !application.isEmpty || !config.isEmpty else {
    //   return nil
    // }
    self.template = !template.isEmpty ? template : nil
    self.xcodeVersion = !xcodeVersion.isEmpty ? xcodeVersion : nil
    self.application = !application.isEmpty ? application : nil
    self.config = !config.isEmpty ? config : nil
  }
  
  var error: CommandLineError? {
    var error: CommandLineError?
    if application == nil && config == nil {
      error = .missingApplication
    } else if config != nil && (template != nil || application != nil || xcodeVersion != nil) {
      error = .soMuchParams
    }
    return error
  }
}
