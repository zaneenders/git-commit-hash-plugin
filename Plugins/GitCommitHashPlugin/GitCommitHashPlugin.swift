import Foundation
import PackagePlugin

@main struct GitCommitHashPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let outputDirectory = context.pluginWorkDirectoryURL
        let outputFile = outputDirectory.appendingPathComponent("_GitInfo.swift")

        let process = Process()
        // Optional add --short
        // git rev-parse --short HEAD
        process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
        process.arguments = ["rev-parse", "HEAD"]

        let pipe = Pipe()
        process.standardOutput = pipe

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let commitHash = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines)
        else {
            fatalError("Could not get git commit hash.")
        }

        let fileContent = """
            public enum GitInfo {
                public static let commitHash: StaticString = "\(commitHash)"
            }
            """

        try fileContent.write(to: outputFile, atomically: true, encoding: .utf8)

        return [
            .prebuildCommand(
                displayName: "Injecting GitInfo.swift into the build",
                executable: URL(fileURLWithPath: "/usr/bin/touch"),
                arguments: [outputFile.path],
                outputFilesDirectory: outputDirectory
            )
        ]
    }
}
