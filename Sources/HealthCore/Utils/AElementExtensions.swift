import Foundation
import AEXML

extension AEXMLElement {
    public func asDate(_ name: String, _ formatter: DateFormatter) -> Date? {
        if let v = self.attributes[name] {
            return formatter.date(from: v)
        }
        return nil
    }

    public func asDouble(_ name: String) -> Double? {
        if let v = self.attributes[name] {
            return Double(v)
        }
        return nil
    }

    public func asInt(_ name: String) -> Int? {
        if let v = self.attributes[name] {
            return Int(v)
        }
        return nil
    }

    public func asString(_ name: String) -> String? {
        if let v = self.attributes[name] {
            return v
        }
        return nil
    }
}
