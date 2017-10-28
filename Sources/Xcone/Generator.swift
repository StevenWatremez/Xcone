//
//  Generator.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 28/10/2017.
//

import Commander

internal struct Generator {
 func generate(template: String,
                       xcodeVersion: String,
                       application: String,
                       config: String) {
    // TODO : check template :
    // - if it's just name, search inside resources to find this template
    // - if it's a path, use this template to render icon
    print("template : \(template)")
    // TODO : use xcode version to render template icon with this version.
    print("xcodeVersion : \(xcodeVersion)")
    // TODO : use application to target Xcode application inside folder Application.
    print("application : \(application)")
    // TODO : use config to manipulate yaml config file to ease multiple Xcode manipulation
    print("config : \(config)")
    
    // TODO : if auto-all is called :
    // - Find an Xcode in Application folder
    // - Find it's version number info.plist :: CFBundleShortVersionString
    // - Find it's icon name inside info.plist :: CFBundleIconFile
  }
}
