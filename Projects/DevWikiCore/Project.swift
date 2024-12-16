//
//  Project.swift
//  Config
//
//  Created by yuraMacBookPro on 12/16/24.
//

import ProjectDescription

private let deploymentTargets: DeploymentTargets = .iOS("16.0")

let project = Project(
    name: "DevWikiCore",
    targets: [
        .target(
            name: "DevWikiCore",
            destinations: .iOS,
            product: .staticLibrary,
            bundleId: "io.tuist.DevWikiCore",
            deploymentTargets: deploymentTargets,
            sources: "Sources/**",
            dependencies: []
        )
    ]
)
