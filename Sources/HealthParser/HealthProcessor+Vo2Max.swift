import HealthCore
import AEXML

//  <Record type="HKQuantityTypeIdentifierVO2Max" sourceName="Shoe" unit="mL/min·kg" 
//      creationDate="2020-04-10 17:05:31 -0700" startDate="2020-04-10 17:05:31 -0700" 
//      endDate="2020-04-10 17:05:31 -0700" value="38.9846">
//   <MetadataEntry key="HKVO2MaxTestType" value="2"/>
//  </Record>
extension HealthProcessor {
    func processVo2Max(_ ele: AEXMLElement) {
        let r = ValueRecord(ele)
        let (key, list) = processValue(vo2MaxTimeMap, r, ele)
        vo2MaxTimeMap[key] = list
    }
}
