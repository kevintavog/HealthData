import HealthCore
import AEXML

// <Record type="HKQuantityTypeIdentifierWalkingHeartRateAverage" sourceName="Shoe" sourceVersion="6.2.1" 
//  unit="count/min" creationDate="2020-04-10 17:05:19 -0700" startDate="2020-04-10 06:57:02 -0700" 
//  endDate="2020-04-10 17:05:11 -0700" value="109"/
extension HealthProcessor {
    func processWalkingHeartRateAverage(_ ele: AEXMLElement) {
        let r = ValueRecord(ele)
        let (key, list) = processValue(walkingHeartRateAverageTimeMap, r, ele)
        walkingHeartRateAverageTimeMap[key] = list
    }
}
