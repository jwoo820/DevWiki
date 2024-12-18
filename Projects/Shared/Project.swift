//
//  Project.swift
//  Config
//
//  Created by yuraMacBookPro on 12/12/24.
//

import ProjectDescription

private let deploymentTargets: DeploymentTargets = .iOS("16.0")

let project = Project(
    name: "Shared",
    targets: [
        .target(
            name: "Shared",
            destinations: .iOS,
            product: .staticLibrary,
            bundleId: "com.DevWiki.Shared",
            deploymentTargets: deploymentTargets,
            sources: "Sources/**",
            dependencies: []
        )
    ]
)
