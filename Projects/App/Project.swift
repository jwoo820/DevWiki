import ProjectDescription

private let appName = "App"
private let bundleId = "com.DevWiki.App"
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
                    "CFBundleDisplayName": "DevWiki", // 앱 이름,
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Shared", path: "../Shared"),
                .project(target: "Core", path: "../Core")
            ]
        ),
        .target(
            name: "DevWikiTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.DevWiki.DevWikiTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: appName)]
        ),
    ]
)
