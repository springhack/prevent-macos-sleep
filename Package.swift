import PackageDescription

let package = Package(
    name: "prevent-macos-sleep",
    targets: [
        Target(name: "prevent-macos-sleep", dependencies: ["Clibproc"])
    ]
)
