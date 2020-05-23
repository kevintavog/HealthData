import Foundation

public enum SampleType: String, Codable {
    case activeEnergyBurned, appleExerciseTime, appleStandTime, basalEnergy
    case distance, environmentalAudioExposure
    case flight, headphoneAudioExposure, heartRate, heartRateVariabilitySDNN
    case restingHeartRate, step, vo2Max, walkingHeartRateAverage
}

public struct GroupedCounts: Codable, CustomStringConvertible {
    public let type: SampleType
    public let sourceName: String
    public let deviceDetails: DeviceDetails
    public let records: [CountRecord]

    public init(type: SampleType, sourceName: String, deviceDetails: DeviceDetails, records: [CountRecord]) {
        self.type = type
        self.sourceName = sourceName
        self.deviceDetails = deviceDetails
        self.records = records
    }

    public var startDateUTC: Date {
        return self.records.first!.startUTC
    }

    public var description: String {
        return "\(type) from \(sourceName), \(records.count) records"
    }
}

public struct GroupedValues: Codable, CustomStringConvertible {
    public let type: SampleType
    public let sourceName: String
    public let deviceDetails: DeviceDetails
    public let records: [ValueRecord]

    public init(type: SampleType, sourceName: String, deviceDetails: DeviceDetails, records: [ValueRecord]) {
        self.type = type
        self.sourceName = sourceName
        self.deviceDetails = deviceDetails
        self.records = records
    }

    public var startDateUTC: Date {
        return self.records.first!.startUTC
    }

    public var description: String {
        return "\(type) from \(sourceName)-\(deviceDetails.name), \(records.count) records"
    }
}
