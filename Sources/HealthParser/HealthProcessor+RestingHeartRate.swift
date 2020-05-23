import HealthCore
import AEXML

//  <Record type="HKQuantityTypeIdentifierRestingHeartRate" sourceName="Shoe" sourceVersion="6.2.1" 
//      unit="count/min" creationDate="2020-04-10 21:29:45 -0700" startDate="2020-04-10 06:57:02 -0700" 
//      endDate="2020-04-10 21:25:56 -0700" value="54"/>
extension HealthProcessor {
    func processRestingHeartRate(_ ele: AEXMLElement) {
        let r = ValueRecord(ele)
        let (key, list) = processValue(restingHeartRateTimeMap, r, ele)
        restingHeartRateTimeMap[key] = list
    }
}

