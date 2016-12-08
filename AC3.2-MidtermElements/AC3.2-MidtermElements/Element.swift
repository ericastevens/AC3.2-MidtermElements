//
//  Element.swift
//  AC3.2-MidtermElements
//
//  Created by Erica Y Stevens on 12/8/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import Foundation

class Element {
    var id: Int
    var recordURL: String
    var name: String
    var symbol: String
    var number: Int
    var weight: Double?
    var discoveryYear: Int?
    var group: Int?
    var meltingC: Int?
    var boilingC: Int?
    var density: Double?
    var crustPercent: Double?
    var electrons: String?
    var ionEnergy: Double?
    
    init?(from dict: [String:Any]) {
        guard let name = dict["name"] as? String,
            let id = dict["id"] as? Int,
            let recordURL = dict["record_url"] as? String,
            let symbol = dict["symbol"] as? String,
            let number = dict["number"] as? Int else { return nil }
            let weight = dict["weight"] as? Double? ?? nil
            let discoveryYear = dict["discovery_year"] as? Int? ?? nil
            let group = dict["group"] as? Int? ?? nil
            let meltingC = dict["melting_c"] as? Int? ?? nil
            let boilingC = dict["boiling_c"] as? Int? ?? nil
            let density = dict["density"] as? Double? ?? nil
            let crustPercent = dict["crust_percent"] as? Double? ?? nil
            let electrons = dict["electrons"] as? String? ?? nil
            let ionEnergy = dict["ion_energy"] as? Double? ?? nil
        self.id = id
        self.name = name
        self.recordURL = recordURL
        self.symbol = symbol
        self.number = number
        self.weight = weight
        self.discoveryYear = discoveryYear
        self.group = group
        self.meltingC = meltingC
        self.boilingC = boilingC
        self.density = density
        self.crustPercent = crustPercent
        self.electrons = electrons
        self.ionEnergy = ionEnergy
    }
    
    static func parseElements(from arr: [[String:Any]]) -> [Element] {
        var elements = [Element]()
        
        arr.forEach { (jsonDict) in
            if let element = Element(from: jsonDict) {
                elements.append(element)
            }
        }
        return elements
    }
}
