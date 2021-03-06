//
//  Command.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 28/10/2017.
//

import Foundation

public struct CommandLine {
  let template: String?
  let xcodeVersion: String?
  let application: String?
  let config: String?
  
  public init(template: String,
              xcodeVersion: String,
              application: String,
              config: String) {
    self.template = !template.isEmpty ? template : nil
    self.xcodeVersion = !xcodeVersion.isEmpty ? xcodeVersion : nil
    self.application = !application.isEmpty ? application : nil
    self.config = !config.isEmpty ? config : nil
  }
  
  public func parse(completion: (_ result: CommandLineResult) -> Void) {
    if self.application == nil && self.template == nil && self.xcodeVersion == nil && self.config == nil {
      completion(.failure(error: .noParams))
    } else if self.application == nil && self.config == nil {
      completion(.failure(error: .missingApplication))
    } else if self.config != nil && (self.template != nil || self.application != nil || self.xcodeVersion != nil) {
      completion(.failure(error: .soMuchParams))
    } else if let application = self.application {
      let params = Params(template: self.template, xcodeVersion: self.xcodeVersion, application: application)
      completion(.success(type: .cli(params: params)))
    } else if self.config != nil {
      completion(.success(type: .yaml))
    }
  }
}

extension CommandLine: CustomStringConvertible {
  public var description: String {
    var rDescription: String = "-------------------------------------------"
    rDescription += "\n:: CommandLine ::"
    rDescription += self.template != nil ? "\ntemplate = \(self.template ?? "")" : ""
    rDescription += self.xcodeVersion != nil ? "\nxcode-version = \(self.xcodeVersion ?? "")" : ""
    rDescription += self.application != nil ? "\napplication = \(self.application ?? "")" : ""
    rDescription += self.config != nil ? "\nconfig = \(self.config ?? "")" : ""
    rDescription += "\n-------------------------------------------"
    return rDescription
  }
}
