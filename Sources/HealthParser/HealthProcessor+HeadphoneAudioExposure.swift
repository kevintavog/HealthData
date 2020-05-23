import HealthCore
import AEXML

//  <Record type="HKQuantityTypeIdentifierHeadphoneAudioExposure" sourceName="Agent86" sourceVersion="13.4" 
//      device="&lt;&lt;HKDevice: 0x28195d900&gt;, name:Powerbeats3, manufacturer:Apple Inc., model:0x2003, localIdentifier:80:4A:14:86:BB:FB-tacl&gt;" 
//      unit="dBASPL" creationDate="2020-04-10 16:18:43 -0700" startDate="2020-04-10 16:07:42 -0700" 
//      endDate="2020-04-10 16:16:29 -0700" value="56.8794"/>
extension HealthProcessor {
    func processHeadphoneAudioExposure(_ ele: AEXMLElement) {
        let r = ValueRecord(ele)
        let (key, list) = processValue(headphoneAudioExposureTimeMap, r, ele)
        headphoneAudioExposureTimeMap[key] = list
    }
}
