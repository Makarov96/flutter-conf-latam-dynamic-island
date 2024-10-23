//
//  UberModel.swift
//  Runner
//
//  Created by Guerin Steven Colocho Chacon on 6/10/24.
//

import Foundation

struct UberModel: Codable {
    var uberLogo: String
    var uberArriveTime: String
    var uberCarPlate: String
    var uberDriverName: String
    var uberDriverImage: String
    var uberAddress: String
    var assetCar: String
    var uberProgress: Double
    
    // Initialize directly from the provided mapper dictionary
    init(from mapper: [String: AnyCodable]) throws {
        guard
            let uberLogo = mapper["uber_logo"]?.value as? String,
            let uberArriveTime = mapper["uber_arrive_time"]?.value as? String,
            let uberCarPlate = mapper["uber_car_plate"]?.value as? String,
            let uberDriverName = mapper["uber_driver_name"]?.value as? String,
            let uberDriverImage = mapper["uber_driver_image"]?.value as? String,
            let assetCar = mapper["asset_car"]?.value as? String,
            let uberAddress = mapper["uber_address"]?.value as? String,
            let uberProgress = mapper["uber_progress"]?.value as? Double
        else {
            throw NSError(domain: "UberModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid or missing values in mapper."])
        }
        
        self.uberLogo = uberLogo
        self.uberArriveTime = uberArriveTime
        self.uberCarPlate = uberCarPlate
        self.uberDriverName = uberDriverName
        self.uberDriverImage = uberDriverImage
        self.assetCar = assetCar
        self.uberProgress = uberProgress
        self.uberAddress = uberAddress
    }
}
