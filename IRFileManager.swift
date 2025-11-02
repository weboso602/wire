import Foundation

struct IRFileManager {
    static let baseURL: URL = {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let path = dir.appendingPathComponent("IRSignals", isDirectory: true)
        try? FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
        return path
    }()

    static func saveIR(name: String, data: Data) throws {
        let url = baseURL.appendingPathComponent("\(name).irb")
        try data.write(to: url, options: .atomic)
    }

    static func loadIR(name: String) -> Data? {
        let url = baseURL.appendingPathComponent("\(name).irb")
        return try? Data(contentsOf: url)
    }

    static func listAll() -> [String] {
        (try? FileManager.default.contentsOfDirectory(atPath: baseURL.path))?
            .filter { $0.hasSuffix(".irb") }
            .map { $0.replacingOccurrences(of: ".irb", with: "") } ?? []
    }
}