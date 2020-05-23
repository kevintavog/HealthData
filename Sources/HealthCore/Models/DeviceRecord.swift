import Foundation

public struct DeviceRecord: Codable {
    public let id: String
    public let deviceName: String
    public let details: DeviceDetails

    public init(deviceName: String, detailsField: String) {
        self.details = DeviceDetails.from(detailsField: detailsField)
        self.deviceName = deviceName
        self.id = "\(details.manufacturer)-\(details.model)-\(details.hardware)"
    }
}

public struct DeviceDetails: Codable {
    public let name: String
    public let hardware: String
    public let manufacturer: String
    public let model: String

    public init(name: String, hardware: String, manufacturer: String, model: String) {
        self.name = name
        self.hardware = hardware
        self.manufacturer = manufacturer
        self.model = model
    }
}

extension DeviceDetails {
    static func from(detailsField: String?) -> DeviceDetails {
        var name = ""
        var hardware = ""
        var manufacturer = ""
        var model = ""

        if let details = detailsField {
            let nameValues = details.filter { $0 != "<" && $0 != ">" }.split(separator: ",")
            for nv in nameValues {
                let tokens = nv.split(separator: ":")
                if tokens.count == 2 {
                    let key = tokens[0].trimmingCharacters(in: .whitespaces)
                    let value = tokens[1].trimmingCharacters(in: .whitespaces)
                    switch key {
                        case "name":
                            name = value
                            break
                        case "hardware":
                            hardware = value
                            break
                        case "manufacturer":
                            manufacturer = value
                            if manufacturer == "Apple Inc." {
                                manufacturer = "Apple"
                            }
                            break
                        case "model":
                            model = value
                            break
                        default:
                            break
                    }
                }
            }

            // Powerbeats hardware isn't set, so grab the name
            if hardware == "" && name.count > 0 {
                hardware = name
            }
        }

        return DeviceDetails(name: name, hardware: hardware, manufacturer: manufacturer, model: model)
    }
}
