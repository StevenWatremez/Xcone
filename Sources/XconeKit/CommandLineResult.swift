//
//  CommandLineResult.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 29/10/2017.
//

import Foundation

public enum CommandLineResult {
  case success(type: CommandLineType)
  case failure(error: CommandLineError)
}
