//
//  MagickWandService.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 01/11/2017.
//

import Foundation

internal struct MagickWandService {
  private enum Wand {
    /// convert -resize 1024x1024 ../Xcode-icon.png icon_512x512@2x.png
    static let convert = "convert"
  }
  
  private enum Arguments {
    /// -resize 128x128
    static let resize = "-resize"
    /// -fill white
    static let fill = "-fill"
    /// -draw 'text 500,500 "9.0"'
    static let annotate = "-annotate"
    /// -pointsize 270
    static let pointSize = "-pointSize"
    /// -size 1024x1024
    static let size = "-size"
    /// -gravity Center
    static let gravity = "-gravity"
  }
  
  private let type: WandType
  
  init(type: WandType) {
    self.type = type
  }
  
  var arguments: [String] {
    var rArguments: [String] = []
    switch self.type {
    case .resize(let wand): rArguments = self.generateResizeArguments(with: wand)
    case .text(let wand): rArguments = self.generateTextArguments(with: wand)
    }
    return rArguments
  }
  
  /// convert -resize 128x128 ../Xcode-banner.png icon_512x512@2x.png
  private func generateResizeArguments(with wand: WandResize) -> [String] {
    var rArguments: [String] = []
    // -resize
    rArguments.append(Arguments.resize)
    let convertOption = String(format: "%dx%d", wand.width, wand.height)
    rArguments.append(convertOption)
    // input
    rArguments.append(wand.input)
    // output
    rArguments.append(wand.output)
    return rArguments
  }
  
  /// convert icon.png -size 1024x1024 -pointsize 270 -gravity Center \
  ///         -fill white -annotate -9x-9+35+0 9.0 icon-generate.png
  private func generateTextArguments(with wand: WandText) -> [String] {
    var rArguments: [String] = []
    // -size
    rArguments.append(Arguments.size)
    let convertOption = String(format: "%dx%d", wand.width, wand.height)
    rArguments.append(convertOption)
    // -pointSize
    rArguments.append(Arguments.pointSize)
    let pointSizeOption = String(format: "%d", wand.pointSize)
    rArguments.append(pointSizeOption)
    // -gravity
    rArguments.append(Arguments.gravity)
    let gravityOption = String(format: "%@", wand.gravity.rawValue)
    rArguments.append(gravityOption)
    // -fill
    rArguments.append(Arguments.fill)
    let fillOption = String(format: "%@", wand.fill.rawValue)
    rArguments.append(fillOption)
    // -annotate
    rArguments.append(Arguments.annotate)
    rArguments.append(contentsOf: wand.draw.arguments)
    // input
    rArguments.append(wand.input)
    // output
    rArguments.append(wand.output)
    return rArguments
  }
}
