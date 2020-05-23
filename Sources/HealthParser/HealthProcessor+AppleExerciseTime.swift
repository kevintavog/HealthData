import HealthCore
import AEXML

//  <Record type="HKQuantityTypeIdentifierAppleExerciseTime" sourceName="Shoe" sourceVersion="6.2.1" 
//      device="&lt;&lt;HKDevice: 0x281ac6580&gt;, name:Apple Watch, manufacturer:Apple Inc., model:Watch, hardware:Watch4,2, software:6.2.1&gt;" 
//      unit="min" creationDate="2020-04-10 07:56:00 -0700" startDate="2020-04-10 07:48:39 -0700" 
//      endDate="2020-04-10 07:49:39 -0700" value="1"/>

extension HealthProcessor {
    func processAppleExerciseTime(_ ele: AEXMLElement) {
        let r = ValueRecord(ele)
        let (key, list) = processValue(appleExerciseTimeTimeMap, r, ele)
        appleExerciseTimeTimeMap[key] = list
    }
}
