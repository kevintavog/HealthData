import HealthCore
import AEXML

// <Record type="HKQuantityTypeIdentifierDistanceWalkingRunning" sourceName="Agent86" 
// sourceVersion="12.0" device="&lt;&lt;HKDevice: 0x2800cc2d0&gt;, name:iPhone, 
// manufacturer:Apple, model:iPhone, hardware:iPhone11,6, software:12.0&gt;" 
// unit="mi" creationDate="2018-09-22 16:22:27 -0700" startDate="2018-09-22 16:10:24 -0700" 
// endDate="2018-09-22 16:10:34 -0700" value="0.00979281"/>

extension HealthProcessor {
    func processDistanceWalkingRunning(_ ele: AEXMLElement) {
        let r = ValueRecord(ele)
        let (key, list) = processValue(distanceTimeMap, r, ele)
        distanceTimeMap[key] = list
    }
}
