//
//  ViewController.swift
//  StationBike
//
//  Created by William Souef on 17/10/2023.
//

import UIKit
import MapKit

class MapAnnotationViewController: UIViewController, MKMapViewDelegate {

    private let myLocation = CLLocation(latitude: 43.6598 , longitude: 7.2148)
    @IBOutlet weak var mapView: MKMapView!


    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.centerToLocation(myLocation)
        fetchData()
        mapView.delegate = self
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MapAnnotation else {
            return nil
        }

        let identifier = "MyPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        annotationView?.glyphImage = .actions
        annotationView?.rightCalloutAccessoryView = UIButton(type: .infoLight)
        annotationView?.showsLargeContentViewer = true

        return annotationView
    }

    private func fetchData() {
        guard let url = URL(string: "https://opendata.nicecotedazur.org/data/storage/f/2014-05-13T08%3A22%3A17.827Z/velobleu.json") else {
            return
        }
        URLSession.shared.dataTask(with: url) { [self] data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode([String: [BikeStation]].self, from: data)
                    // Extract the array under "docs"
                    let bikeStations = response["docs"] ?? []
                    for bikeStation in bikeStations {
                        let annotation = bikeStation.updateModeltoMapAnnotation()
                        mapView.addAnnotation(annotation)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }

}
private extension MKMapView{
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 15000){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
