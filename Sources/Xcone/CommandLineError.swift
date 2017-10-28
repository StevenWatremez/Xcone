//
//  CommandLineError.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 28/10/2017.
//

import Foundation

internal enum CommandLineError: Error {
  case missingApplication
  case soMuchParams
  
  func printError() {
    let printErrorDescription: String
    switch self {
    case .missingApplication: printErrorDescription = "--application parameter is missing"
    case .soMuchParams: printErrorDescription = "You can't use --application, --template or --xcode-version parameters in the same time with --config"
    }
    print(printErrorDescription)
  }
}
