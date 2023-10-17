//
//  BikeStation.swift
//  StationBike
//
//  Created by William Souef on 17/10/2023.
//

import Foundation
import MapKit

struct BikeStation: Codable, Identifiable {
    var id: String?
    var name: String?
    var availableBikes: Int?
    var availableBikeStands: Int?
    var location: String?
    var moreInfo: String?
    var geometry: Geometry

    enum CodingKeys: String, CodingKey {
        case id = "IDENT"
        case name = "NOM_VOIE"
        case availableBikes = "NBR_VELO"
        case availableBikeStands = "NBR_PT_ACC"
        case location = "EMPLACEMEN"
        case moreInfo = "COMPL_LOC"
        case geometry
    }
}

struct Geometry: Codable {
    let type: String?
    let coordinates: [Double]?
}
extension BikeStation {

    func updateModeltoMapAnnotation() -> MapAnnotation {
        let title = name
        let subtitle = moreInfo
        let coordinate = CLLocationCoordinate2D(latitude: geometry.coordinates![1], longitude: geometry.coordinates![0])
        return MapAnnotation(title: title, subtitle: subtitle, coordinate: coordinate)
    }
}
