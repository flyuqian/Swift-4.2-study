/*
 解析特殊结构的json
 
 */
import UIKit







class T3Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        test1()
        test2()
        
    }
    
    
    
    
    
    
    

    

}




// 解析 test3 中两种数据类型
enum Fuel: String, Decodable {
    case jetA = "Jet A"
    case jetB = "Jet B"
    case oneHundredLowlead = "100L"
}
struct AmericanFuelPrice: Decodable {
    let fuel: Fuel
    let price: Double
}
struct CanadianFuelPrice: Decodable {
    let type: Fuel
    let price: Double
}
struct FuelPrice {
    let type: Fuel
    let pricePerLiter: Double
    let currency: String
}
extension FuelPrice {
    init(_ other: AmericanFuelPrice) {
        self.type = other.fuel
        self.pricePerLiter = other.price / 3.78541
        self.currency = "USD"
    }
}
extension FuelPrice {
    init(_ other: CanadianFuelPrice) {
        self.type = other.type
        self.pricePerLiter = other.price
        self.currency = "CAD"
    }
}
// 如果数据源种类较少, 优先上边定义
// 如果数据源种类较多, 则使用下边
protocol FuelPriceP {
    var type: Fuel { get }
    var pricePerLiter: Double { get }
    var currency: String { get }
}
extension AmericanFuelPrice: FuelPriceP {
    var type: Fuel {
        return self.fuel
    }
    var pricePerLiter: Double {
        return self.price / 3.78541
    }
    var currency: String {
        return "USD"
    }
    
}
extension CanadianFuelPrice: FuelPriceP {
    var pricePerLiter: Double {
        return self.price
    }
    
    var currency: String {
        return "CAD"
    }
    
}



// MARK: 从多种表示法中解析数据
extension T3Controller {
    func test3() {
        let json1 = """
        [
            {
                "fuel": "100LL",
                "price": 5.60
            },
            {
                "fuel": "Jet A",
                "price": 4.10
            }
        ]
        """.data(using: .utf8)
        
        let json2 = """
        {
            "fuels": [
                {
                    "type": "100LL",
                    "price": 2.54
                },
                {
                    "type": "Jet A",
                    "price": 3.14,
                },
                {
                    "type": "Jet B",
                    "price": 3.03
                }
            ]
        }
        """
    }
}







// MARK: 解析随机类型








// MARK: 解析未确定的类型
struct Bird: Decodable {
    var genus: String
    var species: String
}
struct Plane2: Decodable {
    var identifier: String
}
enum Either<T, U> {
    case left(T)
    case right(U)
}
extension Either: Decodable where T: Decodable, U: Decodable {
    init(from decoder: Decoder) throws {
        if let value = try? T(from: decoder) {
            self = .left(value)
        }
        else if let value = try? U(from: decoder) {
            self = .right(value)
        }
        else {
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Cannot decode \(T.self) or \(U.self)")
            throw DecodingError.dataCorrupted(context)
        }
    }
}

extension T3Controller {
    // 解析未确定的类型
    func test2() {
        let json = """
            [
                {
                    "type": "bird",
                    "genus": "Chaetura",
                    "species": "Vauxi"
                },
                {
                    "type": "plane",
                    "identifier": "NA12345"
                }
            ]
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let objects = try! decoder.decode([Either<Bird, Plane2>].self, from: json)
        for obj in objects {
            switch obj {
            case .left(let brid):
                print("Poo-tee-weet? Its \(brid.genus) \(brid.species)")
            case .right(let plan):
                print("Vooooooooooooo! Its \(plan.identifier)")
            }
        }
    }
}





//MARK: 未知键

struct Route: Decodable {
    struct Airport: Decodable {
        var code: String
        var name: String
    }
    var points: [Airport]
    
    init(from coder: Decoder) throws {
        let container = try coder.container(keyedBy: CodingKeys.self)
        var points: [Airport] = []
        let codes = try container.decode([String].self, forKey: .points)
        for code in codes {
            let key = CodingKeys(stringValue: code)!
            let airport = try container.decode(Airport.self, forKey: key)
            points.append(airport)
        }
        self.points = points
    }
    
    private struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int? {
            return nil
        }
        init?(intValue: Int) {
            return nil
        }
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        static let points = CodingKeys(stringValue: "points")!
    }
}
extension T3Controller {
    // 未知键
    func test1() {
        
        let json = """
        {
            "points": ["KSQL", "KWVI"],
            "KSQL": {
                "code": "KSQL",
                "name": "San Carlos Airport"
            },
            "KWVI": {
                "code": "KWVI",
                "name": "Watsonville Municipal Airport"
            }
        }
        """.data(using: .utf8)!
        let route = try! JSONDecoder().decode(Route.self, from: json)
        for point in route.points {
            print(point.name)
        }
        
    }
}
