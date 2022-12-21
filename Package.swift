// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IntaroCards",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "IntaroCards", targets: ["IntaroCards"])
    ],
    targets: [
        .target(name: "IntaroCards", path: "Sources")
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
