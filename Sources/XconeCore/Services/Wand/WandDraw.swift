//
//  WandDraw.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 02/11/2017.
//

import Foundation

internal struct WandDraw {
  let text: String
  let rotation: Int8
  let translation: (x: Int8, y: Int8)
}

internal struct Draw {
  private enum DrawArguments {
    /// rotate -20
    static let rotate = "rotate"
    /// text 0,0 "9.0"
    static let text = "text"
    /// translation 50,50
    static let translation = "translation"
  }
  
  private let wand: WandDraw
  
  init(wand: WandDraw) {
    self.wand = wand
  }
  
  var argument: String {
    var rArgument: String = ""
    // translate
    rArgument += DrawArguments.translation
    rArgument += " "
    rArgument += String(format: "%d,%d", self.wand.translation.x, self.wand.translation.y)
    
    // rotate
    rArgument += DrawArguments.rotate
    rArgument += " "
    rArgument += String(format: "%d", self.wand.rotation)
    
    rArgument += DrawArguments.text
    rArgument += " 0,0" // TODO : check if this value is necessary
    rArgument += " "
    rArgument += String(format: "\"%@\"", self.wand.text)
    
    return rArgument
  }
}
