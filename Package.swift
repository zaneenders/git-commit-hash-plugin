// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "git-commit-hash-plugin",
    products: [
        .plugin(
            name: "GitCommitHashPlugin",
            targets: ["GitCommitHashPlugin"])
    ],
    targets: [
        // DummyTarget is needed for Package.swift to build
        .target(name: "DummyTarget"),
        .plugin(
            name: "GitCommitHashPlugin", capability: .buildTool()),
    ]
)
