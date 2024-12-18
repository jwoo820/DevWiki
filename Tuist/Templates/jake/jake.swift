//
//  jake.swift
//  Config
//
//  Created by yuraMacBookPro on 12/18/24.
//

import ProjectDescription

// command line 입력 --name 파라미터에 들어가는 값
// ex) tuist scaffold jake --name1 hihi
let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Custom template",
    attributes: [
        nameAttribute
    ],
    items: [
        .string(
            path: "README.md",
            contents: "# \(nameAttribute)"
        )
    ]
)
