// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cooponent",
    platforms: [
        .iOS(.v15),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Cooponent",
            targets: ["Button", "Segment", "Examples"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Button",
            dependencies: []),
        .target(
            name: "Segment",
            dependencies: []),
        .target(
            name: "Examples",
            dependencies: ["Button", "Segment"]),
        .testTarget(
            name: "CooponentTests",
            dependencies: ["Button", "Segment"])
    ]
)
