//
//  MapService.swift
//  HelpCov
//
//  Created by Antoine Simon on 29/05/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import MapKit
import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol MapServiceProtocol: AnyObject {
    func addValue(name: String ,location: CLLocationCoordinate2D, address: String, maskCutomer: Bool, maskEmploye: Bool, distancing: Bool, completion: @escaping ((Result<Void, Error>) -> Void))
    func getValue(completion: @escaping ((Result<[ListPoint], Error>) -> Void))
}

final class MapService: NSObject {
    let userID = Auth.auth().currentUser?.uid
    var ref: DatabaseReference = Database.database().reference()
}

extension MapService: MapServiceProtocol {
    func getValue(completion: @escaping ((Result<[ListPoint], Error>) -> Void)) {
        ref.child("items").observe(.value) { (snapshot) in
            completion(.success(Parser().parseItemList(snapshot: snapshot)))
        }
    }
    
    func addValue(name: String ,location: CLLocationCoordinate2D, address: String, maskCutomer: Bool, maskEmploye: Bool, distancing: Bool, completion: @escaping ((Result<Void, Error>) -> Void)) {
        
        let entry: [String: Any] = ["title" : name,
                                    "latitude" : location.latitude,
                                    "longitude" : location.longitude,
                                    "address" : address,
                                    "haveCandy" : maskCutomer,
                                    "veganCandy" : maskEmploye,
                                    "halalCandy" : distancing]
        
        ref.child("items").child(address).childByAutoId().setValue(entry) { (Error, DatabaseReference) in
            if let error = Error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
