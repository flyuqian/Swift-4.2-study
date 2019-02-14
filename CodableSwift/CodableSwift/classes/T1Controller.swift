//
//  T1Controller.swift
//  CodableSwift
//
//  Created by IOS3 on 2019/1/23.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit



struct Plane: Codable {
    var manufacturer: String
    var model: String
    var seats: Int
    
    /*
    private enum CodingKeys: String, CodingKey {
        case manufacturer
        case model
        case seats
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.manufacturer = try container.decode(String.self, forKey: .manufacturer)
        self.model = try container.decode(String.self, forKey: .model)
        self.seats = try container.decode(Int.self, forKey: .seats)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.manufacturer, forKey: .manufacturer)
        try container.encode(self.model, forKey: .model)
        try container.encode(self.seats, forKey: .seats)
    }
 */
}



class T1Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
            
    }
    
    
    func test2() {
        let json = """
        [
            {
                "manufacturer": "Cessna",
                "model": "172 Skyhawk",
                "seats": 4
            },
            {
                "manufacturer": "Piper",
                "model": "PA-28 Cherokee",
                "seats": 4
            }
        ]
        """.data(using: .utf8)!
        
        let plans = try! JSONDecoder().decode([Plane].self, from: json)
        
        /*
        {
            "planes": [
            {
            "manufacturer": "Cessna",
            "model": "172 Skyhawk",
            "seats": 4
            },
            {
            "manufacturer": "Piper",
            "model": "PA-28 Cherokee",
            "seats": 4
            }
            ]
        }
         -> [String : [Plane]]
        */
        
        
    }
    
    
    func test1() {
        let json = """
        {
            "manufacturer": "Cessna",
            "model": "172 Skyhawk",
            "seats": 4,
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let plane = try! decoder.decode(Plane.self, from: json)
        
        print("manufacturer: \(plane.manufacturer), model: \(plane.model), seats: \(plane.seats)")
        
        let encoder = JSONEncoder()
        let reencodedJson = try! encoder.encode(plane)
        print(String(data: reencodedJson, encoding: .utf8)!)
    }

    

}
