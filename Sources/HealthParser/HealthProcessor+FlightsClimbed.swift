import HealthCore
import AEXML

// <Record type="HKQuantityTypeIdentifierFlightsClimbed" sourceName="Agent86" 
// sourceVersion="12.0" device="&lt;&lt;HKDevice: 0x2800880a0&gt;, name:iPhone, 
// manufacturer:Apple, model:iPhone, hardware:iPhone11,6, software:12.0&gt;" 
// unit="count" creationDate="2018-09-22 22:43:02 -0700" startDate="2018-09-22 22:30:57 -0700"
// endDate="2018-09-22 22:30:59 -0700" value="1"/>

// <Record type="HKQuantityTypeIdentifierFlightsClimbed" sourceName="Shoe" sourceVersion="5.2.1" 
// device="&lt;&lt;HKDevice: 0x2800c6850&gt;, name:Apple Watch, manufacturer:Apple Inc., 
// model:Watch, hardware:Watch4,2, software:5.2.1&gt;" unit="count" 
// creationDate="2019-07-17 21:45:08 -0700" startDate="2019-07-17 21:33:54 -0700" 
// endDate="2019-07-17 21:34:12 -0700" value="2"/>
extension HealthProcessor {
    func processFlightsClimbed(_ ele: AEXMLElement) {
        let r = CountRecord(ele)
        let (key, list) = processCount(flightsTimeMap, r, ele)
        flightsTimeMap[key] = list
    }
}
