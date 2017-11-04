//
//  WandDraw.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 02/11/2017.
//

import Foundation

internal struct WandDraw {
  private enum DrawArguments {
    /// rotate -20
    static let rotate = "rotate"
    /// text 0,0 "9.0"
    static let text = "text"
    /// translation 50,50
    static let translation = "translation"
  }
  
  let text: String
  let rotation: Int8
  let translation: (x: Int8, y: Int8)
  
  init(text: String, rotation: Int8, translation: (x: Int8, y: Int8)) {
    self.text = text
    self.rotation = rotation
    self.translation = translation
  }
  
  var arguments: [String] {
    var rArguments: [String] = []
    // rotate
    let rotation = String(format: "%dx%d+%d+%d", self.rotation, self.rotation, self.translation.y, self.translation.x)
    rArguments.append(rotation)
    rArguments.append(String(format: "%@", self.text))
    return rArguments
  }
}
