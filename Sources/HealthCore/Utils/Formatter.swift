import Foundation

public struct Formatter {
    static private var _recordDateFormatter: DateFormatter?
    static private var _keyDateFormatter: DateFormatter?

    static public var recordDateFormatter: DateFormatter {
        if _recordDateFormatter == nil {
            _recordDateFormatter = DateFormatter()
            _recordDateFormatter!.timeZone = TimeZone(secondsFromGMT: 0)
            _recordDateFormatter!.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        }
        return _recordDateFormatter!
    }

    static public var keyDateFormatter: DateFormatter {
        if _keyDateFormatter == nil {
            _keyDateFormatter = DateFormatter()
            _keyDateFormatter!.timeZone = TimeZone(secondsFromGMT: 0)
            _keyDateFormatter!.dateFormat = "yyyy-MM-dd-HH"
        }
        return _keyDateFormatter!
    }

    static public var dateOnlyFormatter: DateFormatter {
        return keyDateFormatter
    }
}
