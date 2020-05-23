import HealthCore
import AEXML

// <Record type="HKQuantityTypeIdentifierBasalEnergyBurned" sourceName="Shoe" sourceVersion="6.2" 
//   device="&lt;&lt;HKDevice: 0x281acdfe0&gt;, name:Apple Watch, manufacturer:Apple Inc., model:Watch, hardware:Watch4,2, software:6.2&gt;" 
//   unit="kcal" creationDate="2020-04-05 15:46:53 -0700" startDate="2020-04-05 15:46:44 -0700" 
//   endDate="2020-04-05 15:46:47 -0700" value="0.067"/>
extension HealthProcessor {
    func processBasalEnergyBurned(_ ele: AEXMLElement) {
        let r = ValueRecord(ele)
        let (key, list) = processValue(basalEnergyTimeMap, r, ele)
        basalEnergyTimeMap[key] = list
    }
}
