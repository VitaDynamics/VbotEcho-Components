// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "VbotEchoComponents",
    defaultLocalization: "zh-Hans",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [.library(name: "VbotEchoComponents", targets: ["VbotEchoComponents"])],
    targets: [
        .target(name: "VbotEchoComponents", resources: [.process("Resources")]),
        .testTarget(name: "VbotEchoComponentsTests", dependencies: ["VbotEchoComponents"])
    ]
)
