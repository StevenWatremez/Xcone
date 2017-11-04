//
//  WandType.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 02/11/2017.
//

import Foundation

enum WandType {
  case resize(wand: WandResize)
  case text(wand: WandText)
}

struct WandResize {
  let width: Int16
  let height: Int16
  let input: Path
  let output: Path
}

enum Color: String {
  case white
  case none
}

enum Gravity: String {
  case center = "Center"
  case none
}

/// MagickWandService(.resize(width: 128, height: 128, input: "../Xcode-banner.png", output: "icon_512x512@2x.png")))
struct WandText {
  let width: Int16
  let height: Int16
  let pointSize: Int16
  let fill: Color
  let gravity: Gravity
  var draw: WandDraw
  let input: Path
  let output: Path
}
