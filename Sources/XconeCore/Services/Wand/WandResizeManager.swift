//
//  WandResize.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 04/11/2017.
//

import Foundation
import Files

struct Resize {
  let size: Int16
  let name: String
  let is2x: Bool
  
  init(size: Int16, is2x: Bool = false) {
    self.size = size
    let rightSize = is2x ? size / 2 : size
    let sizeName = "\(rightSize)x\(rightSize)"
    self.name = "icon_\(sizeName)" + (is2x ? "@2x" : "") + ".png"
    self.is2x = is2x
  }
}

extension Resize: CustomStringConvertible {
  var description: String {
    return "Resize :: size = \(self.size), name = \(self.name), is2x = \(self.is2x)"
  }
}

struct WandResizeManager {
  func resizeAll(xcode: XcodeDetail, templateFolder: Folder, iconsetFolder: Folder) {
    let resizeList: [Resize] = [
      Resize(size: 16),
      Resize(size: 32, is2x: true),
      Resize(size: 32),
      Resize(size: 64, is2x: true),
      Resize(size: 64),
      Resize(size: 128, is2x: true),
      Resize(size: 128),
      Resize(size: 256, is2x: true),
      Resize(size: 256),
      Resize(size: 512, is2x: true),
      Resize(size: 512),
      Resize(size: 1024, is2x: true)
    ]
    
    resizeList.forEach { (resize: Resize) in
      print(resize.description)
      self.resize(xcode: xcode,
                  templateFolder: templateFolder,
                  iconsetFolder: iconsetFolder,
                  size: resize.size,
                  outputName: resize.name)
    }
  }
  
  private func resize(xcode: XcodeDetail,
                      templateFolder: Folder,
                      iconsetFolder: Folder,
                      size: Int16,
                      outputName: String) {
    let wandresize = WandResize(width: size,
                                height: size,
                                input: templateFolder.path + "\(xcode.iconName).png",
                                output: iconsetFolder.path + outputName)
    let resizeMagickWand = MagickWandService(type: .resize(wand: wandresize))
    let resize = resizeMagickWand.arguments.shellExec("/usr/local/opt/imagemagick/bin/convert")
    print(resizeMagickWand.arguments.description)
    print(resize)
  }
}
