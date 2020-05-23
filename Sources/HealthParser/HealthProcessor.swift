import Foundation
import HealthCore

import AEXML

class HealthProcessor {
    let earliestDate: Date?
    let latestDate: Date?

    var allDevices = Set<String>()
    var devices = [DeviceRecord]()

    // Time (yyyy-MM-dd) -> Array of records
    var activeEnergyBurnedTimeMap = [String: [ValueRecord]]()
    var appleExerciseTimeTimeMap = [String: [ValueRecord]]()
    var appleStandTimeTimeMap = [String: [ValueRecord]]()
    var basalEnergyTimeMap = [String: [ValueRecord]]()
    var distanceTimeMap = [String: [ValueRecord]]()
    var environmentalAudioExposureTimeMap = [String: [ValueRecord]]()
    var flightsTimeMap = [String: [CountRecord]]()
    var headphoneAudioExposureTimeMap = [String: [ValueRecord]]()
    var heartRateTimeMap = [String: [ValueRecord]]()
    var heartRateVariabilitySDNNTimeMap = [String: [ValueRecord]]()
    var restingHeartRateTimeMap = [String: [ValueRecord]]()
    var stepsTimeMap = [String: [CountRecord]]()
    var vo2MaxTimeMap = [String: [ValueRecord]]()
    var walkingHeartRateAverageTimeMap = [String: [ValueRecord]]()

    var unhandledRecordTypes = Set<String>()
    var unhandledRoot = Set<String>()

    init(_ startDate: Date?, _ endDate: Date?) {
        self.earliestDate = startDate
        self.latestDate = endDate
    }

    func process(_ inputFile: String, _ outputFolder: String) throws {
        let xml = try AEXMLDocument(xml: String.read(contentsOfFile: inputFile))

        print("Processing records...")
        for child in xml.root.children {
            switch child.name {
                case "Record":
                    processRecord(child)
                    break
                case "ExportDate", "Me", "ActivitySummary", "Workout":
                    break
                default:
                    unhandledRoot.insert(child.name)
                    break
            }
        }

        if unhandledRoot.count > 0 {
            print("Unhandled roots: \(unhandledRoot)")
        }
        if unhandledRecordTypes.count > 0 {
            print("Unhandled record types: \(unhandledRecordTypes)")
        }

        print("Saving records to \(outputFolder)")
        try writeRecords(outputFolder)
    }

    func sortAndDedup(_ list: [String]) -> [String] {
        var unique = Set<String>()
        for l in list {
            unique.insert(l)
        }
        return Array(unique).sorted()
    }

    func getKey(_ utcDate: Date) -> String {
        return Formatter.keyDateFormatter.string(from: utcDate)
    }

    func addDevice(_ sourceName: String, _ details: String?) {
        if let d = details {
            let dev = DeviceRecord(deviceName: sourceName, detailsField: d)
            if !allDevices.contains(dev.id) {
                allDevices.insert(dev.id)
                devices.append(dev)
            }
        }
    }
}
