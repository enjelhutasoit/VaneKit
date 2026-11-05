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
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.0")
    ],
    targets: [
        .target(name: "VaneKit"),
        .testTarget(
            name: "VaneKitTests",
            dependencies: [
                "VaneKit",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ]
        )
    ]
)
