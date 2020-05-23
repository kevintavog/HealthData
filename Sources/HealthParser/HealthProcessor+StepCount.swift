import HealthCore
import AEXML

// <Record type="HKQuantityTypeIdentifierStepCount" sourceName="Bertha" unit="count" 
// creationDate="2014-11-16 07:11:12 -0800" startDate="2014-11-15 14:21:29 -0800" 
// endDate="2014-11-15 14:21:31 -0800" value="2"/>

// <Record type="HKQuantityTypeIdentifierStepCount" sourceName="Shoe" sourceVersion="5.2.1" 
// device="&lt;&lt;HKDevice: 0x2800c3c00&gt;, name:Apple Watch, manufacturer:Apple Inc., 
// model:Watch, hardware:Watch4,2, software:5.2.1&gt;" unit="count" 
// creationDate="2019-07-17 21:36:38 -0700" startDate="2019-07-17 21:25:11 -0700" 
// endDate="2019-07-17 21:34:53 -0700" value="873"/>

// <Record type="HKQuantityTypeIdentifierStepCount" sourceName="Agent86" 
// sourceVersion="12.3.1" device="&lt;&lt;HKDevice: 0x2800cc0a0&gt;, name:iPhone, 
// manufacturer:Apple Inc., model:iPhone, hardware:iPhone11,6, software:12.3.1&gt;" 
// unit="count" creationDate="2019-07-18 08:15:25 -0700" startDate="2019-07-18 08:02:10 -0700" 
// endDate="2019-07-18 08:02:13 -0700" value="22"/>

extension HealthProcessor {
    func processStepCount(_ ele: AEXMLElement) {
        let r = CountRecord(ele)
        let (key, list) = processCount(stepsTimeMap, r, ele)
        stepsTimeMap[key] = list
    }
}
