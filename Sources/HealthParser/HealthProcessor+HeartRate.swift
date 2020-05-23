import HealthCore
import AEXML

//  <Record type="HKQuantityTypeIdentifierHeartRate" sourceName="Shoe" sourceVersion="6.2.1" 
//      device="&lt;&lt;HKDevice: 0x28197ec10&gt;, name:Apple Watch, manufacturer:Apple Inc., model:Watch, hardware:Watch4,2, software:6.2.1&gt;" 
//      unit="count/min" creationDate="2020-04-10 12:29:16 -0700" startDate="2020-04-10 12:25:33 -0700" endDate="2020-04-10 12:25:33 -0700" value="67">
//   <MetadataEntry key="HKMetadataKeyHeartRateMotionContext" value="1"/>
//  </Record>
extension HealthProcessor {
    func processHeartRate(_ ele: AEXMLElement) {
        let r = ValueRecord(ele)
        let (key, list) = processValue(heartRateTimeMap, r, ele)
        heartRateTimeMap[key] = list
    }
}
