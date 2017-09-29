
import PackageDescription

let package = Package(
	name: "LiteraryHeavenServer",
	targets: [],
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
        .Package(url:"https://github.com/PerfectlySoft/Perfect-MySQL.git", majorVersion: 2),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-Crypto.git", majorVersion: 3)
    ]
)
