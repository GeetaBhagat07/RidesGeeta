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
    let color: String?
    let doors: Int?
    let drive_type: String?
    let fuel_type: String?
    let kilometrage: Int?
    let license_plate: String?
    let mileage: Int?
    let specs: Array<String>?
    let transmission: String?
    let car_options: Array<String>?

    enum CodingKeys: String, CodingKey {
        case vin = "vin"
        case make_and_model = "make_and_model"
        case car_type = "car_type"
        case color = "color"
        case doors = "doors"
        case drive_type = "drive_type"
        case fuel_type = "fuel_type"
        case kilometrage = "kilometrage"
        case license_plate = "license_plate"
        case mileage = "mileage"
        case specs = "specs"
        case transmission = "transmission"
        case car_options = "car_options"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        vin = try values.decodeIfPresent(String.self, forKey: .vin)
        make_and_model = try values.decodeIfPresent(String.self, forKey: .make_and_model)
        car_type = try values.decodeIfPresent(String.self, forKey: .car_type)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        doors = try values.decodeIfPresent(Int.self, forKey: .doors)
        drive_type = try values.decodeIfPresent(String.self, forKey: .drive_type)
        fuel_type = try values.decodeIfPresent(String.self, forKey: .fuel_type)
        kilometrage = try values.decodeIfPresent(Int.self, forKey: .kilometrage)
        license_plate = try values.decodeIfPresent(String.self, forKey: .license_plate)
        mileage = try values.decodeIfPresent(Int.self, forKey: .mileage)
        specs = try values.decodeIfPresent(Array.self, forKey: .specs)
        transmission = try values.decodeIfPresent(String.self, forKey: .transmission)
        car_options = try values.decodeIfPresent(Array.self, forKey: .car_options)
    }
}
