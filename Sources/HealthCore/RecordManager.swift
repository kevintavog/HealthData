import Foundation

public class RecordManager {

    static public var recordsFolder: String = ""

    static public func getDay(date: Date) throws -> DayRecord? {
        if recordsFolder == "" {
            throw HealthError.unexpected(message: "recordsFolder not set")
        }
        let tokens = Formatter.dateOnlyFormatter.string(from: date).components(separatedBy: "-")
        let path = "\(recordsFolder)/\(tokens[0])/\(tokens[1])/\(tokens[2]).json"
        let record = try DayRecord.fromJson(data: Data(contentsOf: URL(fileURLWithPath: path)))
        return record
    }
}