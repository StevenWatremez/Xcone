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
    let fileSystem = FileSystem()
    let applicationParam = XcodeApplication(application: params.application, xcodeVersion: params.xcodeVersion, serialization: serialization, fileSystem: fileSystem)
    if let detail = applicationParam.detail {
      // TODO : here manage the following generation with xcode detail
      print(detail.description)
    } else {
      print("failed to find Xcode application !")
    }
  }
}
