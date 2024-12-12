//
//  Project.swift
//  Config
//
//  Created by yuraMacBookPro on 12/12/24.
//

import ProjectDescription

let project = Project(
    name: "DevWikiUI",
    targets: [
        .target(
            name: "DevWikiUI",
            destinations: .iOS,
            product: .staticLibrary,
            bundleId: "io.tuist.DevWikiUI",
            sources: "Sources/**",
            dependencies: []
        )
    ]
)
