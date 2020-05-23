import Foundation
import HealthCore

import AEXML
import FileUtils

extension HealthProcessor {
    func processRecord(_ ele: AEXMLElement) {
        if let type = ele.attributes["type"] {
            // "2020-04-10 16:53:33 -0700"
            let startDate = ele.asDate("startDate", Formatter.recordDateFormatter)!
            let endDate = ele.asDate("endDate", Formatter.recordDateFormatter)!
            if let earliest = earliestDate {
                if startDate < earliest {
                    return
                }
            }

            if let latest = latestDate {
                if endDate > latest {
                    return
                }
            }

            switch type {
                case "HKQuantityTypeIdentifierBodyMass",
                     "HKQuantityTypeIdentifierHeight":
                    break

                //    "HKCategoryTypeIdentifierAppleStandHour"
                //     "HKCategoryTypeIdentifierMindfulSession",
                //     "HKCategoryTypeIdentifierSleepAnalysis",

                case "HKQuantityTypeIdentifierActiveEnergyBurned":
                    processActiveEnergyBurned(ele)
                    break

                case "HKQuantityTypeIdentifierAppleExerciseTime":
                    processAppleExerciseTime(ele)
                    break

                case "HKQuantityTypeIdentifierAppleStandTime":
                    processAppleStandTime(ele)
                    break

                case "HKQuantityTypeIdentifierBasalEnergyBurned":
                    processBasalEnergyBurned(ele)
                    break

                case "HKQuantityTypeIdentifierDistanceWalkingRunning":
                    processDistanceWalkingRunning(ele)
                    break

                case "HKQuantityTypeIdentifierEnvironmentalAudioExposure":
                    processEnvironmentalAudioExposure(ele)
                    break

                case "HKQuantityTypeIdentifierFlightsClimbed":
                    processFlightsClimbed(ele)
                    break

                case "HKQuantityTypeIdentifierHeadphoneAudioExposure":
                    processHeadphoneAudioExposure(ele)
                    break

                case "HKQuantityTypeIdentifierHeartRate":
                    processHeartRate(ele)
                    break

                case "HKQuantityTypeIdentifierHeartRateVariabilitySDNN":
                    processHeartRateVariabilitySDNN(ele)
                    break

                case "HKQuantityTypeIdentifierRestingHeartRate":
                    processRestingHeartRate(ele)
                    break

                case "HKQuantityTypeIdentifierStepCount":
                    processStepCount(ele)
                    break

                case "HKQuantityTypeIdentifierVO2Max":
                    processVo2Max(ele)
                    break

                case "HKQuantityTypeIdentifierWalkingHeartRateAverage":
                    processWalkingHeartRateAverage(ele)
                    break

                default:
                    unhandledRecordTypes.insert(type)
                    break
            }
        } else {
            print("Missing type for \(ele)")
        }
    }

    func processValue(_ map: [String: [ValueRecord]], _ valRecord: ValueRecord, _ ele: AEXMLElement) -> (String, [ValueRecord]) {
        addDevice(valRecord.sourceName, ele.asString("device"))
        let key = getKey(valRecord.startUTC)
        var list = map[key, default: [ValueRecord]()]
        list.append(valRecord)
        return (key, list)
    }

    func processCount(_ map: [String: [CountRecord]], _ record: CountRecord, _ ele: AEXMLElement) -> (String, [CountRecord]) {
        addDevice(record.sourceName, ele.asString("device"))
        let key = getKey(record.startUTC)
        var list = map[key, default: [CountRecord]()]
        list.append(record)
        return (key, list)
    }

    func writeRecords(_ outputFolder: String) throws {
print("Check if 'HKCategoryTypeIdentifierAppleStandHour' can be used to determine wake/sleep times")

        var keys = Array(activeEnergyBurnedTimeMap.keys) + appleExerciseTimeTimeMap.keys + appleStandTimeTimeMap.keys
            + basalEnergyTimeMap.keys
        keys += Array(distanceTimeMap.keys) + environmentalAudioExposureTimeMap.keys + flightsTimeMap.keys
            + headphoneAudioExposureTimeMap.keys + heartRateTimeMap.keys + heartRateVariabilitySDNNTimeMap.keys
        keys += Array(restingHeartRateTimeMap.keys) + stepsTimeMap.keys + vo2MaxTimeMap.keys 
            + walkingHeartRateAverageTimeMap.keys
        let allKeys = sortAndDedup(keys)

        for key in allKeys.sorted() {
            let tokens = key.components(separatedBy: "-")
            DirectoryHelper.createDirectories(baseFolder: outputFolder, subFolders: tokens[0], tokens[1])
            let filename = "\(outputFolder)/\(tokens[0])/\(tokens[1])/\(tokens[2])-\(tokens[3]).json"

            // Each day will have one or more sources, separate by sourceName & sort each list by time, ascending
            var activeEnergyBurnedRecords = [GroupedValues]()
            var appleExerciseTimeRecords = [GroupedValues]()
            var appleStandTimeRecords = [GroupedValues]()
            var basalEnergyRecords = [GroupedValues]()
            var distanceRecords = [GroupedValues]()
            var environmentalAudioExposureRecords = [GroupedValues]()
            var flightsRecords = [GroupedCounts]()
            var headphoneAudioExposureRecords = [GroupedValues]()
            var heartRateRecords = [GroupedValues]()
            var heartRateVariabilitySDNNRecords = [GroupedValues]()
            var restingHeartRateRecords = [GroupedValues]()
            var stepRecords = [GroupedCounts]()
            var vo2MaxRecords = [GroupedValues]()
            var walkingHeartRateAverageRecords = [GroupedValues]()

            for dev in devices {
                addValues(activeEnergyBurnedTimeMap, key, dev.deviceName, dev.details) { records in
                    activeEnergyBurnedRecords.append(
                        GroupedValues(type: .activeEnergyBurned, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }

                addValues(appleExerciseTimeTimeMap, key, dev.deviceName, dev.details) { records in
                    appleExerciseTimeRecords.append(
                        GroupedValues(type: .appleExerciseTime, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }

                addValues(appleStandTimeTimeMap, key, dev.deviceName, dev.details) { records in
                    appleStandTimeRecords.append(
                        GroupedValues(type: .appleStandTime, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }

                addValues(basalEnergyTimeMap, key, dev.deviceName, dev.details) { records in
                    basalEnergyRecords.append(
                        GroupedValues(type: .basalEnergy, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }

                addValues(distanceTimeMap, key, dev.deviceName, dev.details) { records in
                    distanceRecords.append(
                        GroupedValues(type: .distance, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }

                addValues(environmentalAudioExposureTimeMap, key, dev.deviceName, dev.details) { records in
                    environmentalAudioExposureRecords.append(
                        GroupedValues(type: .environmentalAudioExposure, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }

                addValues(flightsTimeMap, key, dev.deviceName, dev.details) { records in
                    flightsRecords.append(
                        GroupedCounts(type: .flight, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }

                addValues(headphoneAudioExposureTimeMap, key, dev.deviceName, dev.details) { records in
                    headphoneAudioExposureRecords.append(
                        GroupedValues(type: .headphoneAudioExposure, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }

                addValues(heartRateTimeMap, key, dev.deviceName, dev.details) { records in
                    heartRateRecords.append(
                        GroupedValues(type: .heartRate, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }

                addValues(heartRateVariabilitySDNNTimeMap, key, dev.deviceName, dev.details) { records in
                    heartRateVariabilitySDNNRecords.append(
                        GroupedValues(type: .heartRateVariabilitySDNN, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }

                addValues(restingHeartRateTimeMap, key, dev.deviceName, dev.details) { records in
                    restingHeartRateRecords.append(
                        GroupedValues(type: .restingHeartRate, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }

                addValues(stepsTimeMap, key, dev.deviceName, dev.details) { records in
                    stepRecords.append(
                        GroupedCounts(type: .step, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }

                addValues(vo2MaxTimeMap, key, dev.deviceName, dev.details) { records in
                    vo2MaxRecords.append(
                        GroupedValues(type: .vo2Max, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }

                addValues(walkingHeartRateAverageTimeMap, key, dev.deviceName, dev.details) { records in
                    walkingHeartRateAverageRecords.append(
                        GroupedValues(type: .walkingHeartRateAverage, sourceName: dev.deviceName, 
                                        deviceDetails: dev.details, records: records))
                }
            }

            let dayRecord = DayRecord(
                devices: devices,
                activeEnergyBurned: activeEnergyBurnedRecords,
                appleExerciseTime: appleExerciseTimeRecords,
                appleStandTime: appleStandTimeRecords,
                basalEnergy: basalEnergyRecords,
                distances: distanceRecords,
                environmentalAudioExposure: environmentalAudioExposureRecords,
                flights: flightsRecords,
                headphoneAudioExposure: headphoneAudioExposureRecords,
                heartRate: heartRateRecords,
                heartRateVariabilitySDNN: heartRateVariabilitySDNNRecords,
                restingHeartRate: restingHeartRateRecords,
                steps: stepRecords,
                vo2Max: vo2MaxRecords,
                walkingHeartRateAverage: walkingHeartRateAverageRecords)

            try File.write(string: String(data: dayRecord.toJson(), encoding: .utf8)!, toPath: filename)
        }
    }

    func addValues<T:BaseRecord>(_ map: [String: [T]], _ key: String,
                                 _ deviceName: String, _ deviceDetails: DeviceDetails,
                                 _ action: ([T]) -> Void ) {
        let records = (map[key] ?? []).filter {
                $0.sourceName == deviceName && $0.deviceDetails.name == deviceDetails.name
            }
            .sorted(by: { $0.startUTC < $1.startUTC })
        if records.count > 0 {
            action(records)
        }
    }
}
