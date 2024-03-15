// swift-tools-version:5.6

import PackageDescription

let package = Package(
	name: "ChanceKit",
	platforms: [
		.macOS(.v10_11),
	],
	products: [
		.library(name: "ChanceKit", targets: ["ChanceKit"]),
	],
	targets: [
		.target(name: "ChanceKit"),
		.testTarget(name: "ChanceKitTests", dependencies: ["ChanceKit"]),
	]
)
