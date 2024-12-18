//
//  Project+Templates.swift
//  Config
//
//  Created by yuraMacBookPro on 12/17/24.
//

import ProjectDescription

extension Project {
    public static func featureFramework(name: String, dependencies: [TargetDependency] = []) -> Project {
        return Project(
            name: name,
            targets: [
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .staticLibrary,
                    bundleId: "io.tuist.\(name)",
                    deploymentTargets: .iOS("16.0"),
                    sources: ["Sources/**"],
                    dependencies: dependencies
                )
            ]
        )
    }
}
