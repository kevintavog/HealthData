import HealthCore
import AEXML

//  <Record type="HKQuantityTypeIdentifierHeartRateVariabilitySDNN" sourceName="Shoe" sourceVersion="6.2.1" 
//    device="&lt;&lt;HKDevice: 0x2819e9770&gt;, name:Apple Watch, manufacturer:Apple Inc., model:Watch, hardware:Watch4,2, software:6.2.1&gt;" 
//    unit="ms" creationDate="2020-04-10 20:15:11 -0700" startDate="2020-04-10 20:14:05 -0700" 
//    endDate="2020-04-10 20:15:11 -0700" value="49.39">
//      <HeartRateVariabilityMetadataList>
//          <InstantaneousBeatsPerMinute bpm="55" time="20:14:07.68"/>
// [ many deleted ]
//      </HeartRateVariabilityMetadataList>
//  </Record>

extension HealthProcessor {
    func processHeartRateVariabilitySDNN(_ ele: AEXMLElement) {
        let r = ValueRecord(ele)
        let (key, list) = processValue(heartRateVariabilitySDNNTimeMap, r, ele)
        heartRateVariabilitySDNNTimeMap[key] = list
    }
}
