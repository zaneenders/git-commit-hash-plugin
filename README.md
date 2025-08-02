# git-commit-hash-plugin

A simple plugin to have access to your commit hash.

## Example

### Package.swift

```swift
// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "your-package",
    dependencies: [
        .package(url: "https://github.com/zaneenders/git-commit-hash-plugin.git", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "YourTarget",
            plugins: [
                .plugin(name: "GitCommitHashPlugin", package: "git-commit-hash-plugin")
            ]),
    ]
)
```

### YourTarget

```swift
let hash = GitInfo.commitHash
```
