// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "VaneKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "VaneKit", targets: ["VaneKit"])
    ],
    targets: [
        .target(name: "VaneKit")
    ]
)