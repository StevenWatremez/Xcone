//
//  main.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 28/10/2017.
//

import Commander

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
  Option<String>("config", default: "", flag: "c", description: "special yaml config to target specific or multiple Xcode"),
  generator.generate)

main.run() // your application start from here

// USAGE :

// template banner by default

// generate icon for all Xcode in Application folder automaticly
// Xcone auto-all

// to specify just only one Xcode application to update.
// Xcone auto --aplication Xcode-9.0

// you could customize what you really want to do. From auto to custom.
// Xcone --template banner --xcode-version 9.0b3 --application Xcode-9.0

// custom template
// Xcone --template ~/folder/my-banner.stencil --application Xcode-9.0

// Which template engine I could use ?????? 
// - Stencil ++ 
// - Mustache

// idea to manage multiple Xcode auto generate but specific Xcode is to use YAML file to define properties about which Xcode, template and version you want to manipulate
// Instead of adding additional cli like following :
// Xcone auto --aplications [Xcode-9.0, Xcode-9.1] // could be possible ??????
// Xcone --templates [banner, banner, bubble] --xcode-versions [9.0b3, 9.0, 8.3.3] --applications [Xcode-9.0, Xcode, Xcode-8.3.3] // could be possible ??????
