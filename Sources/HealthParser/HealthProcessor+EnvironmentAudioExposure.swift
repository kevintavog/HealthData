import HealthCore
import AEXML

//  <Record type="HKQuantityTypeIdentifierEnvironmentalAudioExposure" sourceName="Shoe" sourceVersion="6.2.1" 
//      device="&lt;&lt;HKDevice: 0x28191be30&gt;, name:Apple Watch, manufacturer:Apple Inc., model:Watch, hardware:Watch4,2, software:6.2.1&gt;" 
//      unit="dBASPL" creationDate="2020-04-10 07:14:16 -0700" startDate="2020-04-10 06:54:07 -0700" 
//      endDate="2020-04-10 07:24:02 -0700" value="43.79"/>
extension HealthProcessor {
    func processEnvironmentalAudioExposure(_ ele: AEXMLElement) {
        let r = ValueRecord(ele)
        let (key, list) = processValue(environmentalAudioExposureTimeMap, r, ele)
        environmentalAudioExposureTimeMap[key] = list
    }
}
