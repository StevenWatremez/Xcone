//
//  String+Path.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 29/10/2017.
//

import Foundation

extension String {
  /// Find if String is a path
  ///
  /// - Returns: boolean if String is a path or not
  func isPath() -> Bool {
    return self.contains("/")
  }
}
