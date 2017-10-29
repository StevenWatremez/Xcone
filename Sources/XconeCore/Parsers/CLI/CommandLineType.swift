//
//  CommandLineType.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 29/10/2017.
//

import Foundation

public enum CommandLineType {
  case cli(params: Params)
  case yaml
}

extension CommandLineType: CustomStringConvertible {
  public var description: String {
    switch self {
    case .cli: return "|| CommandLineType || type: cli"
    case .yaml: return "|| CommandLineType || type: yaml"
    }
  }
}
