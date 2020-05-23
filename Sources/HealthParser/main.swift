import Foundation

import FileUtils
import Guaka


let endDateFlag = Flag(
    shortName: "e", 
    longName: "end", 
    type: String.self, 
    description: "The last date to process (2020-05-17); ignore all records after to this date. The default is the last date in the file", 
    required: false)
let inputFileFlag = Flag(
    shortName: "i", 
    longName: "input", 
    type: String.self, 
    description: "The input file; exported from the iOS Health app.", 
    required: true)
let outputFolderFlag = Flag(
    shortName: "o", 
    longName: "output", 
    type: String.self, 
    description: "The output folder; sub-folders & files will be created", 
    required: true)
let startDateFlag = Flag(
    shortName: "s", 
    longName: "start", 
    type: String.self, 
    description: "The date to start with (2020-05-17); ignore all records prior to this date. The default is the earliest date in the file.", 
    required: false)

let flags = [endDateFlag, inputFileFlag, outputFolderFlag, startDateFlag]

let command = Command(usage: "HealthParser", flags: flags) { flags, args in
    let inputFile = flags.getString(name: "input")!
    let outputFolder = flags.getString(name: "output")!
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

    if !File.exists(inputFile) {
        fail(statusCode: 1, errorMessage: "Input file does not exist: '\(inputFile)'")
    }

    if !Path.exists(outputFolder) {
        fail(statusCode: 1, errorMessage: "Output folder does not exist: '\(outputFolder)'")
    }

    if Path.type(ofPath: outputFolder) != .directory {
        fail(statusCode: 1, errorMessage: "The output folder must be a directory, but it's not: '\(outputFolder)'")
    }

    var startingDateMessage = "from the start of the file."
    var endingDateMessage = "to the end of the file."
    var startDate: Date? = nil
    var endDate: Date? = nil
    if let dtStr = flags.getString(name: "start") {
        if let dt = dateFormatter.date(from: dtStr) {
            startDate = dt
            startingDateMessage = "from \(dateFormatter.string(from: startDate!))"
        } else {
            fail(statusCode: 1, errorMessage: "The start date is not parsable: '\(dtStr)'")
        }
    }
    if let dtStr = flags.getString(name: "end") {
        if let dt = dateFormatter.date(from: dtStr) {
            endDate = dt
            endingDateMessage = "to \(dateFormatter.string(from: endDate!))"
        } else {
            fail(statusCode: 1, errorMessage: "The end date is not parsable: '\(dtStr)'")
        }
    }

    print("Reading \(inputFile) and writing to \(outputFolder); \(startingDateMessage) and \(endingDateMessage)")
    do {
        try HealthProcessor(startDate, endDate).process(inputFile, outputFolder)
    } catch {
        fail(statusCode: 2, errorMessage: "Failed processing: \(error)")
    }
}

command.execute()
