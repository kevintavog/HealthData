import HealthCore
import AEXML

// <Record type="HKQuantityTypeIdentifierAppleStandTime" sourceName="Shoe" unit="min" 
//  creationDate="2020-04-10 07:35:05 -0700" startDate="2020-04-10 07:30:00 -0700" 
//  endDate="2020-04-10 07:35:00 -0700" value="1"/>

extension HealthProcessor {
    func processAppleStandTime(_ ele: AEXMLElement) {
        let r = ValueRecord(ele)
        let (key, list) = processValue(appleStandTimeTimeMap, r, ele)
        appleStandTimeTimeMap[key] = list
    }
}
