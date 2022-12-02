// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
        name: "adventofcode",
        platforms: [
            .macOS(.v10_15),
        ],
        dependencies: [
            // Dependencies declare other packages that this package depends on.
            // .package(url: /* package url */, from: "1.0.0"),
        ],
        targets: [
            .target(name: "data", dependencies: []),

            .target(name: "day0101", dependencies: ["data"]),
            .target(name: "day0102", dependencies: ["data"]),

            .target(name: "day0201", dependencies: ["data"]),
            .target(name: "day0202", dependencies: ["data"]),

            .target(name: "day0301", dependencies: ["data"]),
            .target(name: "day0302", dependencies: ["data"]),
            
            .target(name: "day0401", dependencies: ["data"]),
            .target(name: "day0402", dependencies: ["data"]),

            .target(name: "day0501", dependencies: ["data"]),
            .target(name: "day0502", dependencies: ["data"]),
            
            .target(name: "day0601", dependencies: ["data"]),
            
            .target(name: "day0801", dependencies: ["data"]),
            .target(name: "day0802", dependencies: ["data"]),

            .target(name: "day0901", dependencies: ["data"]),
            .target(name: "day0902", dependencies: ["data"]),
            
            .target(name: "day1101", dependencies: ["data"]),
            .target(name: "day1102", dependencies: ["data"]),
            
            .target(name: "day1201", dependencies: ["data"]),
            .target(name: "day1202", dependencies: ["data"]),
            
            .target(name: "day1301", dependencies: ["data"]),
            .target(name: "day1302", dependencies: ["data"]),
            
            .testTarget(name: "dataTests", dependencies: ["data"]),
        ]
)
