//
/*
 这一节讲不通情况下使用 Codable, // 解析日期格式和枚举值, 以及嵌套的键和null
 */


struct Aircraft: Codable {
    var identification: String
    var color: String
}
enum FlightRules: String, Codable {
    case visual = "VFR"
    case instrument = "IFR"
}
struct FlightPlan: Codable {
    
    var aircraft: Aircraft
    var route: [String]
    var flightRules: FlightRules
    private var departureDates: [String : Date]
    var proposedDepartureDate: Date? {
        return departureDates["proposed"]
    }
    var actualDepartureDate: Date? {
        return departureDates["actual"]
    }
    var remarks: String?
    
    
    
}

extension FlightPlan {
    private enum CodingKeys: String, CodingKey {
        case aircraft
        case flightRules = "flight_rules"
        case route
        case departureDates = "departure_time"
        case remarks
    }
}


import UIKit

class T2Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        test1()
        
    }
    
    
    
    func test1() {
        
        
        let json = """
        {
            "aircraft": {
                "identification": "NA12345",
                "color": "Blue/White"
            },
            "route": ["KTTD", "KHIO"],
            "departure_time": {
                "proposed": "2018-04-20T14:15:00-0700",
                "actual": "2018-04-20T14:20:00-0700"
            },
            "flight_rules": "IFR",
            "remarks": null
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let plan = try! decoder.decode(FlightPlan.self, from: json)
        
        print("plan.aircraft.identification: \(plan.aircraft.identification), plan.actualDepartureDate: \(plan.actualDepartureDate!)")
        
    }

}
