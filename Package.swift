// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "prevent-macos-sleep",
    targets: [
        .target(name: "Cdeps", dependencies: []),
        .target(name: "prevent-macos-sleep", dependencies: ["Cdeps"])
    ]
)
