
import FileUtils

struct DirectoryHelper {
    static func createDirectories(baseFolder: String, subFolders: String...) {
        var path = baseFolder
        for folder in subFolders {
            path += "/\(folder)"
            Directory.create(atPath: path)
        }
    }
}