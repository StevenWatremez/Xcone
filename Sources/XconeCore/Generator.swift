//
//  Generator.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 28/10/2017.
//

import Foundation

public struct Generator {
  
  public init() {}
  
  public func generate(template: String,
                       xcodeVersion: String,
                       application: String,
                       config: String) {
    
    let commandLine = CommandLine(template: template,
                                  xcodeVersion: xcodeVersion,
                                  application: application,
                                  config: config)
    
    print(commandLine.description)
    commandLine.parse() { (result: CommandLineResult) in
      switch result {
      case .success(let type): self.successCLIResult(type: type)
      case .failure(let error): self.errorHandle(error: error)
      }
    }
    
    // TODO : check template :
    // - if it's just name, search inside resources to find this template
    // - if it's a path, use this template to render icon
    // print("template : \(template)")
    // TODO : use xcode version to render template icon with this version.
    // print("xcodeVersion : \(xcodeVersion)")
    // TODO : use application to target Xcode application inside folder Application.
    // print("application : \(application)")
    // TODO : use config to manipulate yaml config file to ease multiple Xcode manipulation
    // print("config : \(config)")
    
    // TODO : if auto-all is called :
    // - Find an Xcode in Application folder
    // - Find it's version number version.plist :: CFBundleShortVersionString
    // - Find it's icon name inside info.plist :: CFBundleIconFile
  }
  
  private func successCLIResult(type: CommandLineType) {
    switch type {
    case .cli(let params): self.fetchXcodeData(params: params)
    case .yaml: break
    }
  }
  
  private func errorHandle(error: CommandLineError) {
    error.printError()
  }
  
  private func fetchXcodeData(params: Params) {
    let serialization = SerializationService()
    let applicationParam = XcodeApplication(application: params.application, xcodeVersion: params.xcodeVersion, serialization: serialization)
    if let detail = applicationParam.detail {
      // TODO : here manage the following generation with xcode detail
      print(detail.description)
    } else {
      print("failed to find Xcode application !")
    }
  }
}
