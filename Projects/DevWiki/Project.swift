import ProjectDescription

let project = Project(
    name: "DevWiki",
    targets: [
        .target(
            name: "DevWiki",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.DevWiki",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: []
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
