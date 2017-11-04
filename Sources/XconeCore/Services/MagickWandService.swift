//
//  MagickWandService.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 01/11/2017.
//

import Foundation

internal struct MagickWandService {
  private enum Wand {
    /// convert -resize 16x16 ../Xcode-icon.png icon_16x16.png
    /// convert -resize 32x32 ../Xcode-icon.png icon_16x16@2x.png
    /// convert -resize 32x32 ../Xcode-icon.png icon_32x32.png
    /// convert -resize 64x64 ../Xcode-icon.png icon_32x32@2x.png
    /// convert -resize 128x128 ../Xcode-icon.png icon_128x128.png
    /// convert -resize 256x256 ../Xcode-icon.png icon_128x128@2x.png
    /// convert -resize 256x256 ../Xcode-icon.png icon_256x256.png
    /// convert -resize 512x512 ../Xcode-icon.png icon_256x256@2x.png
    /// convert -resize 512x512 ../Xcode-icon.png icon_512x512.png
    /// convert -resize 1024x1024 ../Xcode-icon.png icon_512x512@2x.png
    
    /// convert -resize 128x128 ../Xcode-banner.png icon_512x512@2x.png
    /// convert -pointsize 270 -fill white -draw 'text 500,500 "9.0" ' Xcode-banner-test.png Xcode-banner-test-text.png
    /// convert icon.png -size 1024x1024 -pointsize 270 -gravity Center -fill white -draw "rotate -20 text 0,0 '9.0'" icon-generate.png
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
  
  /////////////
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
    rArguments.append(shellElement: Arguments.resize)
    let convertOption = String(format: "%dx%d", wand.width, wand.height)
    rArguments.append(shellElement: convertOption)
    // input
    rArguments.append(shellElement: wand.input)
    // output
    rArguments.append(shellElement: wand.output)
    return rArguments
  }
  
  /// convert icon.png -size 1024x1024 -pointsize 270 -gravity Center -fill white -draw "rotate -20 text 0,0 '9.0'" icon-generate.png
  private func generateTextArguments(with wand: WandText) -> [String] {
    var rArguments: [String] = []
    // -size
    rArguments.append(shellElement: Arguments.size)
    let convertOption = String(format: "%dx%d", wand.width, wand.height)
    rArguments.append(shellElement: convertOption)
    // -pointSize
    rArguments.append(shellElement: Arguments.pointSize)
    let pointSizeOption = String(format: "%d", wand.pointSize)
    rArguments.append(shellElement: pointSizeOption)
    // -gravity
    rArguments.append(shellElement: Arguments.gravity)
    let gravityOption = String(format: "%@", wand.gravity.rawValue)
    rArguments.append(shellElement: gravityOption)
    // -fill
    rArguments.append(shellElement: Arguments.fill)
    let fillOption = String(format: "%@", wand.fill.rawValue)
    rArguments.append(shellElement: fillOption)
    // -annotate
    rArguments.append(shellElement: Arguments.annotate)
    rArguments.append(contentsOf: wand.draw.arguments)
    // input
    rArguments.append(shellElement: wand.input)
    // output
    rArguments.append(shellElement: wand.output)
    
    return rArguments
  }
}
