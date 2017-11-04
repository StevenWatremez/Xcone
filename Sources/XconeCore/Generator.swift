//
//  Generator.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 28/10/2017.
//

import Foundation
import Files

// TODO : REFACT :
// * Better error management.
// * Cleaner code

public struct Generator {
  public init() {}
  public func generate(template: String,
                       xcodeVersion: String,
                       application: String,
                       config: String) {
    
    let commandLine = CommandLine(template: template,
                                  xcodeVersion: xcodeVersion,
                                  application: application,
                                  config: config)
    
    print(commandLine.description)
    commandLine.parse { (result: CommandLineResult) in
      switch result {
      case .success(let type): self.successCLIResult(type: type)
      case .failure(let error): self.errorHandle(error: error)
      }
    }
  }
  
  private func successCLIResult(type: CommandLineType) {
    switch type {
    case .cli(let params): self.fetchXcodeData(params: params)
    case .yaml: break
    }
  }
  
  private func errorHandle(error: CommandLineError) {
    error.printError()
  }
  
  fileprivate func createIcns(_ templateFolder: Folder?, _ detail: XcodeDetail) {
    // iconutil -c icns myimage.iconset
    let iconutilArguments: [String] = ["-c", "icns", "\((templateFolder?.path ?? "") + detail.iconName).iconset"]
    let createIcns = iconutilArguments.shellExec("/usr/bin/iconutil")
    print(createIcns)
  }
  
  private func fetchXcodeData(params: Params) {
    let serialization = SerializationService()
    let fileSystem = FileSystem()
    let applicationParam = XcodeApplication(application: params.application,
                                            xcodeVersion: params.xcodeVersion,
                                            serialization: serialization,
                                            fileSystem: fileSystem)
    guard let xcode = applicationParam.detail else {
      print("failed to find Xcode application !")
      exit(1)
    }
    
    print(xcode.description)
    
    do {
      let xconeTemplate = "~/Pictures/Xcone/templates/banner"
      let xconeTemplateFolder = try Folder(path: xconeTemplate)
      // 1 - prepare temp folder with Resources/templates/banner/
      let folder = Folder.temporary
      try? folder.subfolder(named: "xcone-template").delete()
      let templateFolderCopy = try folder.createSubfolder(named: "xcone-template")
      let templateFolder = try? xconeTemplateFolder.copy(to: templateFolderCopy)
      //    - Add a folder inside it: {{ iconName }}.iconset
      try? templateFolder?.subfolder(named: "\(xcode.iconName).iconset").delete()
      let iconsetFolder = try templateFolder?.createSubfolder(named: "\(xcode.iconName).iconset")
      print("template folder : '\(String(describing: templateFolder?.path))'")
      // 2 - add xcode version on xcode template Xcode-template.png and generate an image Xcode-icon.png
      self.convert(xcode: xcode, templateFolder: templateFolder)
      // 3 - resize xcode icon inside {{ iconName }}.iconset in : 16x16, 16x16@2x, 32x32, 32x32@2x, 64x64, 64x64@2x,
      // 128x128, 128x128@2x, 256x256, 256x256@2x, 512x512, 512x512@2x
      self.resizeAll(xcode: xcode, templateFolder: templateFolder, iconsetFolder: iconsetFolder)
      // 4 - create icns with {{ iconName }}.iconset to {{ iconName }}.icns
      self.createIcns(templateFolder, xcode)
      // 5 - copy and paste icns file into Xcode application
      self.copyIcns(xcode: xcode, templateFolder: templateFolder)
      // 6 - clean temp template directory after finishing.
      // TODO : when error occured, this directory need to be clear too.
      try? templateFolder?.delete()
    } catch {
      print("failed to manage files and folders !")
    }
  }
  
  private func convert(xcode: XcodeDetail, templateFolder: Folder?) {
    let wandDraw = WandDraw(text: xcode.version, rotation: -9, translation: (x: 0, y: 35))
    let wandText = WandText(width: 1024,
                            height: 1024,
                            pointSize: 270,
                            fill: .white,
                            gravity: .center,
                            draw: wandDraw,
                            input: ((templateFolder?.path ?? "") + "Xcode-template.png"),
                            output: ((templateFolder?.path ?? "") + "\(xcode.iconName).png"))
    let textMagickWand = MagickWandService(type: .text(wand: wandText))
    let convert = textMagickWand.arguments.shellExec("/usr/local/opt/imagemagick/bin/convert")
    print(textMagickWand.arguments.description)
    print(convert)
  }
  
  private func resizeAll(xcode: XcodeDetail, templateFolder: Folder?, iconsetFolder: Folder?) {
    self.resize(xcode: xcode, templateFolder: templateFolder,
                iconsetFolder: iconsetFolder, size: 16, outputName: "icon_16x16.png")
    self.resize(xcode: xcode, templateFolder: templateFolder,
                iconsetFolder: iconsetFolder, size: 32, outputName: "icon_16x16@2x.png")
    self.resize(xcode: xcode, templateFolder: templateFolder,
                iconsetFolder: iconsetFolder, size: 32, outputName: "icon_32x32.png")
    self.resize(xcode: xcode, templateFolder: templateFolder,
                iconsetFolder: iconsetFolder, size: 64, outputName: "icon_32x32@2x.png")
    self.resize(xcode: xcode, templateFolder: templateFolder,
                iconsetFolder: iconsetFolder, size: 64, outputName: "icon_64x64.png")
    self.resize(xcode: xcode, templateFolder: templateFolder,
                iconsetFolder: iconsetFolder, size: 128, outputName: "icon_64x64@2x.png")
    self.resize(xcode: xcode, templateFolder: templateFolder,
                iconsetFolder: iconsetFolder, size: 128, outputName: "icon_128x128.png")
    self.resize(xcode: xcode, templateFolder: templateFolder,
                iconsetFolder: iconsetFolder, size: 256, outputName: "icon_128x128@2x.png")
    self.resize(xcode: xcode, templateFolder: templateFolder,
                iconsetFolder: iconsetFolder, size: 256, outputName: "icon_256x256.png")
    self.resize(xcode: xcode, templateFolder: templateFolder,
                iconsetFolder: iconsetFolder, size: 512, outputName: "icon_256x256@2x.png")
    self.resize(xcode: xcode, templateFolder: templateFolder,
                iconsetFolder: iconsetFolder, size: 512, outputName: "icon_512x512.png")
    self.resize(xcode: xcode, templateFolder: templateFolder,
                iconsetFolder: iconsetFolder, size: 1024, outputName: "icon_512x512@2x.png")
  }
  
  private func resize(xcode: XcodeDetail,
                      templateFolder: Folder?,
                      iconsetFolder: Folder?,
                      size: Int16,
                      outputName: String) {
    let wandresize = WandResize(width: size,
                                height: size,
                                input: ((templateFolder?.path ?? "") + "\(xcode.iconName).png"),
                                output: ((iconsetFolder?.path ?? "") + outputName))
    let resizeMagickWand = MagickWandService(type: .resize(wand: wandresize))
    let resize = resizeMagickWand.arguments.shellExec("/usr/local/opt/imagemagick/bin/convert")
    print(resizeMagickWand.arguments.description)
    print(resize)
  }
  
  private func copyIcns(xcode: XcodeDetail, templateFolder: Folder?) {
    do {
      let xcodeApplicationResourcesFolder = try Folder(path: xcode.resourcesPath)
      let xcodeApplicationRootFolder = try Folder(path: xcode.rootPath)
      
      //try FileManager().removeItem(atPath: xcodeApplicationFolder.path)
      let resourcesIcns = try templateFolder?.file(named: "\(xcode.iconName).icns")
      try? xcodeApplicationResourcesFolder.file(named: "\(xcode.iconName).icns").delete()
      try resourcesIcns?.copy(to: xcodeApplicationResourcesFolder)
      
      let rootIcns = try templateFolder?.file(named: "\(xcode.iconName).icns")
      try? xcodeApplicationRootFolder.file(named: "\(xcode.iconName).icns").delete()
      try rootIcns?.copy(to: xcodeApplicationRootFolder)
      print("icon is copied ! You can now restart Xcode to show your new icon and enjoy !")
    } catch {
      if let filesError = error as? Files.FileSystem.Item.OperationError {
        print("error during coying icns : \(filesError)")
      } else {
        print("error during coying icns : \(error.localizedDescription)")
      }
      print("failed to copy icns inside '\(xcode.resourcesPath)' or '\(xcode.rootPath)' xcode folder !")
    }
  }
}
