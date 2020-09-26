// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mia",
    platforms: [.iOS(.v14), .macOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Mia",
            targets: ["Mia"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", .branch("6.33-spm-beta")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Mia",
            dependencies: [.product(name: "FirebaseFirestore", package: "Firebase"), .product(name: "FirebaseFirestoreSwift", package: "Firebase")]),
        .testTarget(
            name: "MiaTests",
            dependencies: ["Mia"]),
    ]
)
