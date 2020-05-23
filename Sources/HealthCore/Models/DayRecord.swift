import Foundation

public struct DayRecord: Codable {
    public let dayDateUTC: Date    // Date only, time is not part of this
    public let devices: [DeviceRecord]

    public let activeEnergyBurned: [GroupedValues]
    public let appleExerciseTime: [GroupedValues]
    public let appleStandTime: [GroupedValues]
    public let basalEnergy: [GroupedValues]
    public let distances: [GroupedValues]
    public let environmentalAudioExposure: [GroupedValues]
    public let flights: [GroupedCounts]
    public let headphoneAudioExposure: [GroupedValues]
    public let heartRate: [GroupedValues]
    public let heartRateVariabilitySDNN: [GroupedValues]
    public let restingHeartRate: [GroupedValues]
    public let steps: [GroupedCounts]
    public let vo2Max: [GroupedValues]
    public let walkingHeartRateAverage: [GroupedValues]

    public init(devices: [DeviceRecord], 
                activeEnergyBurned: [GroupedValues],
                appleExerciseTime: [GroupedValues], appleStandTime: [GroupedValues],
                basalEnergy: [GroupedValues],
                distances: [GroupedValues],
                environmentalAudioExposure: [GroupedValues],
                flights: [GroupedCounts],
                headphoneAudioExposure: [GroupedValues],
                heartRate: [GroupedValues],
                heartRateVariabilitySDNN: [GroupedValues],
                restingHeartRate: [GroupedValues],
                steps: [GroupedCounts],
                vo2Max: [GroupedValues],
                walkingHeartRateAverage: [GroupedValues]) {
        self.devices = devices

        self.activeEnergyBurned = activeEnergyBurned
        self.appleExerciseTime = appleExerciseTime
        self.appleStandTime = appleStandTime
        self.basalEnergy = basalEnergy
        self.distances = distances
        self.environmentalAudioExposure = environmentalAudioExposure
        self.flights = flights
        self.headphoneAudioExposure = headphoneAudioExposure
        self.heartRate = heartRate
        self.heartRateVariabilitySDNN = heartRateVariabilitySDNN
        self.restingHeartRate = restingHeartRate
        self.steps = steps
        self.vo2Max = vo2Max
        self.walkingHeartRateAverage = walkingHeartRateAverage

        var earliest = min(Date(), activeEnergyBurned.first?.startDateUTC ?? Date())
        earliest = min(earliest, appleExerciseTime.first?.startDateUTC ?? earliest)
        earliest = min(earliest, appleStandTime.first?.startDateUTC ?? earliest)
        earliest = min(earliest, basalEnergy.first?.startDateUTC ?? earliest)
        earliest = min(earliest, distances.first?.startDateUTC ?? earliest)
        earliest = min(earliest, environmentalAudioExposure.first?.startDateUTC ?? earliest)
        earliest = min(earliest, flights.first?.startDateUTC ?? earliest)
        earliest = min(earliest, headphoneAudioExposure.first?.startDateUTC ?? earliest)
        earliest = min(earliest, heartRate.first?.startDateUTC ?? earliest)
        earliest = min(earliest, heartRateVariabilitySDNN.first?.startDateUTC ?? earliest)
        earliest = min(earliest, restingHeartRate.first?.startDateUTC ?? earliest)
        earliest = min(earliest, steps.first?.startDateUTC ?? earliest)
        earliest = min(earliest, vo2Max.first?.startDateUTC ?? earliest)
        earliest = min(earliest, walkingHeartRateAverage.first?.startDateUTC ?? earliest)
        self.dayDateUTC = earliest
    }

    public func toJson() throws -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(self)
    }

    static public func fromJson(data: Data) throws -> DayRecord {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(DayRecord.self, from: data)
    }
}
