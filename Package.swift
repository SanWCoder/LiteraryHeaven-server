import PackageDescription

let package = Package(
	name: "PerfectTemplate",
	targets: [],
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
        .Package(url:"https://github.com/PerfectlySoft/Perfect-MySQL.git", majorVersion: 2)
    ]
)
