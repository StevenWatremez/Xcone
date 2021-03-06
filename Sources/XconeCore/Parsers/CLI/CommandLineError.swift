//
//  CommandLineError.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 28/10/2017.
//

import Foundation

public enum CommandLineError: Error {
  case missingApplication
  case soMuchParams
  case noParams
  
  func printError() {
    let printErrorDescription: String
    switch self {
    case .missingApplication: printErrorDescription = "--application parameter is missing"
    case .soMuchParams: printErrorDescription = """
      You can't use
      --application, --template or --xcode-version parameters
      in the same time with --config
      """
    case .noParams: printErrorDescription = "!!!!!! print cli description !!!!!!"
    }
    print(printErrorDescription)
  }
}

extension CommandLineError: CustomStringConvertible {
  public var description: String {
    let rDescription: String
    switch self {
    case .missingApplication: rDescription = "missingApplication"
    case .soMuchParams: rDescription = "soMuchParams"
    case .noParams: rDescription = "noParams"
    }
    return rDescription
  }
}
