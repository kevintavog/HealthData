// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "HealthService",
    platforms: [.macOS(.v10_12)],
    products: [
        // .executable(name: "HealthService", targets: ["HealthService"]),
        .executable(name: "HealthParser", targets: ["HealthParser"]),
        .library(name: "HealthCore", targets: ["HealthCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tadija/AEXML.git", from: "4.4.0"),
        .package(url: "https://github.com/getGuaka/FileUtils.git", from: "0.2.0"),
        .package(url: "https://github.com/nsomar/Guaka.git", from: "0.4.1"),
        .package(url: "https://github.com/vapor/vapor.git", from: "3.3.0"),
    ],
    targets: [
        .target(
            name: "HealthParser",
            dependencies: ["AEXML", "FileUtils", "Guaka", "HealthCore"]),
        // .target(
        //     name: "HealthService",
        //     dependencies: ["Guaka", "HealthCore", "Vapor"]),
        .target(
            name: "HealthCore",
            dependencies: ["AEXML", "Vapor"]),
        // .testTarget(
        //     name: "HealthServiceTests",
        //     dependencies: ["HealthService"]),
    ]
)
