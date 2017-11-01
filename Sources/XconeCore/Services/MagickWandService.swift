//
//  MagickWandService.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 01/11/2017.
//

import Foundation

/// Usage :
/// * MagickWandService(.resize(width: 128, height: 128, input: "../Xcode-banner.png", output: "icon_512x512@2x.png")))
/// * MagickWandService(.text(width: 1024, height: 1024, pointSize: 270, fill: .white (default is .black), gravity: .center (default is .none), draw: Draw(text: "9.0", rotation: 50 (default is 0), translation: 50 (default is 0,0)) input: "../Xcode-banner.png", output: "icon_512x512@2x.png"))
internal struct MagickWandService {
  private enum Wand {
    /// convert -resize 128x128 ../Xcode-banner.png icon_512x512@2x.png
    /// convert -pointsize 270 -fill white -draw 'text 500,500 "9.0" ' Xcode-banner-test.png Xcode-banner-test-text.png
    /// convert icon.png -size 1024x1024 -pointsize 270 -gravity Center -fill white -draw "rotate -20 text 0,0 '9.0'" icon-generate.png
    static let convert = "convert %@ %@ %@"
  }
  
  private enum Arguments {
    /// -resize 128x128
    static let resize = "-resize %dx%d"
    /// -fill white
    static let fill = "-fill %@"
    /// -draw 'text 500,500 "9.0"'
    static let draw = "-draw '%@'"
    /// -pointsize 270
    static let pointSize = "-pointSize %d"
    /// -size 1024x1024
    static let size = "-size %dx%d"
    /// -gravity Center
    static let gravity = "-gravity %@"
  }
  
  private enum DrawArguments {
    /// rotate -20
    static let rotate = "rotate %d,%d"
    /// text 500,500 "9.0"
    static let text = "text %d,%d \"%@\""
    /// translation 50,50
    static let translation = "translation %d,%d"
  }
}
