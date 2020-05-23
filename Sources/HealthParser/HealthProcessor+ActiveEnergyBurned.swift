import HealthCore
import AEXML

// <Record type="HKQuantityTypeIdentifierActiveEnergyBurned" sourceName="Shoe" sourceVersion="6.2.1" 
//  device="&lt;&lt;HKDevice: 0x28193c730&gt;, name:Apple Watch, manufacturer:Apple Inc., model:Watch, hardware:Watch4,2, software:6.2.1&gt;" 
//  unit="kcal" creationDate="2020-04-10 06:55:05 -0700" startDate="2020-04-10 06:53:43 -0700" 
//  endDate="2020-04-10 06:54:44 -0700" value="0.695"/>
extension HealthProcessor {
    func processActiveEnergyBurned(_ ele: AEXMLElement) {
        let r = ValueRecord(ele)
        let (key, list) = processValue(activeEnergyBurnedTimeMap, r, ele)
        activeEnergyBurnedTimeMap[key] = list
    }
}
