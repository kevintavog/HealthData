import Foundation
import AEXML

public protocol BaseRecord: Codable {
    var startUTC: Date { get }
    var endUTC: Date { get }
    var sourceName: String { get }
    var deviceDetails: DeviceDetails { get }
}

public struct CountRecord: BaseRecord, CustomStringConvertible {
    public let startUTC: Date
    public let endUTC: Date
    public let sourceName: String
    public let deviceDetails: DeviceDetails
    public let count: Int

    public init(_ ele: AEXMLElement) {
        count = ele.asInt("value")!
        startUTC = ele.asDate("startDate", Formatter.recordDateFormatter)!
        endUTC = ele.asDate("endDate", Formatter.recordDateFormatter)!
        sourceName = ele.asString("sourceName")!
        deviceDetails = DeviceDetails.from(detailsField: ele.asString("device"))
    }

    public var description: String {
        return "\(startUTC) - \(endUTC), \(count) from \(sourceName); \(deviceDetails.name)"
    }
}

public struct ValueRecord: BaseRecord, CustomStringConvertible {
    public let value: Double
    public let unit: String
    public let startUTC: Date
    public let endUTC: Date
    public let sourceName: String
    public let deviceDetails: DeviceDetails
    public let metadata: [String:String]

    public init(_ ele: AEXMLElement) {
        value = ele.asDouble("value")!
        unit = ele.asString("unit")!
        startUTC = ele.asDate("startDate", Formatter.recordDateFormatter)!
        endUTC = ele.asDate("endDate", Formatter.recordDateFormatter)!
        sourceName = ele.asString("sourceName")!
        deviceDetails = DeviceDetails.from(detailsField: ele.asString("device"))

        var temp = [String:String]()
        if let m = ele["MetadataEntry"].all {
            for kv in m {
                if let key = kv.attributes["key"], let value = kv.attributes["value"] {
                    temp[key] = value
                }
            }
        }
        metadata = temp
    }

    public var description: String {
        return "\(startUTC) - \(endUTC), \(value) from \(sourceName); \(deviceDetails.name)"
    }
}
