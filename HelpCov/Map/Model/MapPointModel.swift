//
//  MapPointModel.swift
//  HelpCov
//
//  Created by Antoine Simon on 29/05/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import Foundation
import FirebaseDatabase
import MapKit
import Firebase
import FirebaseCore

struct MapPoint: Codable {
    let title: String
    
    let latitude: Double
    let longitude: Double
    
    let address: String
    let maskCustomer: Bool
    let maskEmploye: Bool
    let distancing: Bool
        
    func locationCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude,
                                      longitude: self.longitude)
    }
}

struct ListPoint: Codable {
    var array: [MapPoint]
    var rating: Double
}

final class Parser {
    func parseItemList(snapshot: DataSnapshot) -> [ListPoint] {
        let value = snapshot.value as? NSDictionary
        let keys = value?.allKeys
        
        var itemsList: [ListPoint] = []
        
        
        keys?.forEach({ (key) in
            if let rawData = value?[key] as? [String: [String: Any]] {
                var listMapPoint: [MapPoint] = []
                
                for (_, dict) in rawData {
                    listMapPoint.append(MapPoint.init(title: dict["title"] as! String,
                                                       latitude: dict["latitude"] as! Double,
                                                       longitude: dict["longitude"] as! Double,
                                                       address: dict["address"] as! String,
                                                       maskCustomer: dict["haveCandy"] as! Bool,
                                                       maskEmploye: dict["veganCandy"] as! Bool,
                                                       distancing: dict["halalCandy"] as! Bool))
                }
                
                itemsList.append(ListPoint.init(array: listMapPoint, rating: generateRating(mapPoints: listMapPoint)))
            }
        })
        return itemsList
    }
    
    private func generateRating(mapPoints: [MapPoint]) -> Double {
        return 5.0
    }
}
