//
//  Project.swift
//  Config
//
//  Created by yuraMacBookPro on 12/12/24.
//

import ProjectDescription

private let deploymentTargets: DeploymentTargets = .iOS("16.0")

let project = Project(
    name: "DevWikiUI",
    targets: [
        .target(
            name: "DevWikiUI",
            destinations: .iOS,
            product: .staticLibrary,
            bundleId: "io.tuist.DevWikiUI",
            deploymentTargets: deploymentTargets,
            sources: "Sources/**",
            dependencies: []
        )
    ]
)
