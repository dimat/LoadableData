// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoadableData",
    platforms: [
        .iOS(.v15),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LoadableData",
            targets: ["LoadableData"]),
        .library(
            name: "LoadableDataSwiftUI",
            targets: ["LoadableDataSwiftUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/combine-schedulers.git", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LoadableData",
            dependencies: [
                .product(name: "CombineSchedulers", package: "combine-schedulers")
            ]),
        .target(
            name: "LoadableDataSwiftUI",
            dependencies: ["LoadableData"]),
        .testTarget(
            name: "LoadableDataTests",
            dependencies: ["LoadableData"]),
    ]
)
