import ProjectDescription

private let appName = "DevWiki"
private let bundleId = "io.tuist.DevWiki"
private let appVersion: Plist.Value = "1.0.0"
private let bundleVersion: Plist.Value = "1"
private let deploymentTargets: DeploymentTargets = .iOS("16.0")

let project = Project(
    name: appName,
    targets: [
        .target(
            name: appName,
            destinations: [.iPhone],
            product: .app,
            bundleId: bundleId,
            deploymentTargets: deploymentTargets,
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleShortVersionString": appVersion,
                    "CFBundleVersion": bundleVersion,
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                    "CFBundleDisplayName": "\(appName)", // 앱 이름,
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "DevWikiUI", path: "../DevWikiUI"),
                .project(target: "DevWikiCore", path: "../DevWikiCore")
            ]
        ),
        .target(
            name: "DevWikiTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.DevWikiTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "DevWiki")]
        ),
    ]
)
