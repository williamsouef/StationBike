//
//  MapAnnotation.swift
//  StationBike
//
//  Created by William Souef on 17/10/2023.
//

import Foundation
import MapKit


class MapAnnotation : NSObject, MKAnnotation{
    var title : String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D

    init(title: String? = nil, subtitle: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
