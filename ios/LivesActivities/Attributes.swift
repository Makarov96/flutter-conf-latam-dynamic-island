//
//  Attributes.swift
//  Runner
//
//  Created by Guerin Steven Colocho Chacon on 6/10/24.
//

import Foundation
import ActivityKit


public enum TopicOptions: String {
    case uber
    case spotify
}

struct LivesActivitiesAttributes: ActivityAttributes {
    // Assuming this is your ContentState struct
    struct ContentState: Codable, Equatable, Hashable {
        var topic: String
        var mapper: [String: AnyCodable]

        // Custom Equatable implementation (as defined earlier)
        static func ==(lhs: ContentState, rhs: ContentState) -> Bool {
            guard lhs.topic == rhs.topic else { return false }
            guard lhs.mapper.count == rhs.mapper.count else { return false }

            for (key, lhsValue) in lhs.mapper {
                if let rhsValue = rhs.mapper[key] {
                    if !areEqual(lhsValue.value, rhsValue.value) {
                        return false
                    }
                } else {
                    return false
                }
            }
            return true
        }

        // Helper function to compare AnyCodable values
        static func areEqual(_ lhs: Any, _ rhs: Any) -> Bool {
            switch (lhs, rhs) {
            case (let lhs as String, let rhs as String):
                return lhs == rhs
            case (let lhs as Int, let rhs as Int):
                return lhs == rhs
            case (let lhs as Bool, let rhs as Bool):
                return lhs == rhs
            case (let lhs as Double, let rhs as Double):
                return lhs == rhs
            case (let lhs as [Any], let rhs as [Any]):
                return lhs.count == rhs.count && zip(lhs, rhs).allSatisfy { areEqual($0, $1) }
            case (let lhs as [String: Any], let rhs as [String: Any]):
                return lhs.count == rhs.count && lhs.allSatisfy { key, value in
                    if let rhsValue = rhs[key] {
                        return areEqual(value, rhsValue)
                    }
                    return false
                }
            default:
                return false
            }
        }

        // Custom Hashable implementation
        func hash(into hasher: inout Hasher) {
            // Hash the `topic`
            hasher.combine(topic)
            
            // Hash each key-value pair in the `mapper`
            for (key, value) in mapper {
                hasher.combine(key)  // Hash the key
                LivesActivitiesAttributes.ContentState.hashValue(value.value, into: &hasher)  // Hash the value
            }
        }
        
        // Helper function to hash `AnyCodable` values
        static func hashValue(_ value: Any, into hasher: inout Hasher) {
            switch value {
            case let v as String:
                hasher.combine(v)
            case let v as Int:
                hasher.combine(v)
            case let v as Bool:
                hasher.combine(v)
            case let v as Double:
                hasher.combine(v)
            case let v as [Any]:
                for element in v {
                    hashValue(element, into: &hasher)
                }
            case let v as [String: Any]:
                for (key, element) in v {
                    hasher.combine(key)
                    hashValue(element, into: &hasher)
                }
            default:
                // Handle unsupported types
                break
            }
        }
    }

        
        // Helper function to compare two `Any` values
        static func areEqual(_ lhs: Any, _ rhs: Any) -> Bool {
            switch (lhs, rhs) {
            case (let lhs as String, let rhs as String):
                return lhs == rhs
            case (let lhs as Int, let rhs as Int):
                return lhs == rhs
            case (let lhs as Bool, let rhs as Bool):
                return lhs == rhs
            case (let lhs as Double, let rhs as Double):
                return lhs == rhs
            case (let lhs as [Any], let rhs as [Any]):
                return lhs.count == rhs.count && zip(lhs, rhs).allSatisfy { areEqual($0, $1) }
            case (let lhs as [String: Any], let rhs as [String: Any]):
                return lhs.count == rhs.count && lhs.allSatisfy { key, value in
                    if let rhsValue = rhs[key] {
                        return areEqual(value, rhsValue)
                    }
                    return false
                }
            default:
                return false
            }
        }
    


    var name: String
}

extension LivesActivitiesAttributes.ContentState {
     static var smiley: LivesActivitiesAttributes.ContentState {
         let mapper: [String: AnyCodable] = [
                  "uber_logo": AnyCodable("uber_logo"),
                  "uber_arrive_time": AnyCodable("3:09pm"),
                  "uber_car_plate": AnyCodable("77LN"),
                  "uber_driver_name": AnyCodable("Steven"),
                  "uber_driver_image": AnyCodable("https://www.stevencc.dev/assets/02-SRQee8UE.jpg"),
                  "asset_car": AnyCodable("uber"),
                  "uber_address": AnyCodable("130 South Oxford Ave"),
                  "uber_progress": AnyCodable(0.2),
              ]
         return LivesActivitiesAttributes.ContentState(topic: TopicOptions.uber.rawValue, mapper: mapper)
     }
     
      static var starEyes: LivesActivitiesAttributes.ContentState {
          let mapper: [String: AnyCodable] = [
                   "uber_logo": AnyCodable("uber_logo"),
                   "uber_arrive_time": AnyCodable("3:09pm"),
                   "uber_car_plate": AnyCodable("77LN"),
                   "uber_driver_name": AnyCodable("Steven"),
                   "uber_driver_image": AnyCodable("https://www.stevencc.dev/assets/02-SRQee8UE.jpg"),
                   "asset_car": AnyCodable("uber"),
                   "uber_address": AnyCodable("130 South Oxford Ave"),
                   "uber_progress": AnyCodable(0.6),
               ]
          return LivesActivitiesAttributes.ContentState(topic: TopicOptions.uber.rawValue, mapper: mapper)
     }
}
