//
//  main.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 28/10/2017.
//

import Commander
import XconeCore

// USAGE :
// template banner by default

// TODO : generate icon for all Xcode in Application folder automaticly
// Xcone --auto-gen

// to specify just only one Xcode application to update.
// Xcone --aplication Xcode_9.0

// you could customize what you really want to do. From auto to custom.
// Xcone --template banner --xcode-version 9.0b3 --application Xcode_9.0

// TODO : custom template
// Xcone --template ~/folder/Xcode-template.png --application Xcode_9.0

// Which template engine I could use ??????
// - For now the script use ImageMagick image annotation

// TODO : idea to manage multiple Xcode auto generate but specific Xcode is to use YAML file to define properties about which Xcode, template and version you want to manipulate
// Instead of adding additional cli like following :
// Xcone auto --aplications [Xcode_9.0, Xcode_9.1]
// Xcone --templates [banner, banner, bubble] --xcode-versions [9.0b3, 9.0, 8.3.3] --applications [Xcode_9.0, Xcode, Xcode_8.3.3] // could be possible ??????

private let generator = Generator()

private let main = command(
  // auto-all : is used to automate Xcode 
  // --template : is used to specified which icon template you want to create xcode icon
  Option<String>("template", default: "", flag: "t", description: "template name"),
  // --xcode-version : is here to force xcode version to render icon template
  Option<String>("xcode-version", default: "", flag: "x", description: "xcode custom version number"),
  // --application : is used to specified which Xcode you want to change icon of it
  Option<String>("application", default: "", flag: "a", description: "Xcode target application"),
  // --config or -c : is used to specified which Xcode you want to change icon of it
  Option<String>("config",
                 default: "",
                 flag: "c",
                 description: "special yaml config to target specific or multiple Xcode"),
  generator.generate)

main.run() // your application start from here
