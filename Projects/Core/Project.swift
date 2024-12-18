//
//  Project.swift
//  Config
//
//  Created by yuraMacBookPro on 12/16/24.
//

import ProjectDescription

private let deploymentTargets: DeploymentTargets = .iOS("16.0")

//let project = Project.featureFramework(name: "DevWikiCore", dependencies: [])

let project = Project(
    name: "Core",
    targets: [
        .target(
            name: "Core",
            destinations: .iOS,
            product: .staticLibrary,
            bundleId: "com.DevWiki.Core",
            deploymentTargets: deploymentTargets,
            sources: "Sources/**",
            dependencies: []
        )
    ]
)
