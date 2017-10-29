//
//  SerializationService.swift
//  XconePackageDescription
//
//  Created by Steven_WATREMEZ on 29/10/2017.
//

import Foundation
import Files

typealias Path = String

internal struct SerializationService {
  func parse<T: Codable>(path: Path, fileName: String) -> T? {
    let file = try? Folder(path: path).file(named: fileName)
    let decoder = PropertyListDecoder()
    
    guard let dataFile = try? file?.read(),
      let data = dataFile,
      let object: T = try? decoder.decode(T.self, from: data) else {
        return nil
    }
    return object
  }
}
