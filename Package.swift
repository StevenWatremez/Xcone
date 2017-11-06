// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Xcone",
  products: [
    .executable(name: "Xcone", targets: ["Xcone"]),
    .library(name: "XconeCore", targets: ["XconeCore"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/kylef/Commander.git", from: "0.8.0"),
    .package(url: "https://github.com/JohnSundell/Files.git", from: "1.12.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target( name: "Xcone", dependencies: [
      "XconeCore",
      "Commander"
      ]),
    .target(name: "XconeCore", dependencies: ["Files"]),
    .testTarget(name: "XconeTests", dependencies: [
      "XconeCore"
      ]),
    ]
)
