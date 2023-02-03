//
//  VehicleListBase.swift
//  Rides
//
//  Created by ShanuGeet on 2023-02-01.
//

import Foundation
struct VehicleListBase: Codable {
    let vin: String?
    let make_and_model: String?
    let car_type: String?

    enum CodingKeys: String, CodingKey {
        case vin = "vin"
        case make_and_model = "make_and_model"
        case car_type = "car_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        vin = try values.decodeIfPresent(String.self, forKey: .vin)
        make_and_model = try values.decodeIfPresent(String.self, forKey: .make_and_model)
        car_type = try values.decodeIfPresent(String.self, forKey: .car_type)
    }
}
