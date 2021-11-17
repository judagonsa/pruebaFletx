//
//  TruckMapViewController.swift
//  PruebaFletx
//
//  Created by Julian González on 16/11/21.
//

import UIKit
import MapKit
import CoreLocation

class TruckMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var truck = Truck()
    var lon: Double = 0.0
    var lat: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
    }
    
    func configureMapView() {
        let data = truck.lonlat.components(separatedBy: " ")
        
        lon = Double(String(data[1].dropFirst()))!
        
        lat = Double(String(data[2].dropLast()))!
        
        mapView.region.center.latitude = lat
        mapView.region.center.longitude = lon
        mapView.region.span.latitudeDelta = 0.00725;
        mapView.region.span.longitudeDelta = 0.00725;
        
        addAnnotation()
    }
    
    func addAnnotation() {
        let truckAnnotation = MKPointAnnotation()
        truckAnnotation.title = truck.name
        truckAnnotation.subtitle = "\(truck.plate!) (\(truck.available! ? "Disponible" : "No disponible"))"
        truckAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        mapView.addAnnotation(truckAnnotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "truckIdentifier"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            if let data = NSData(contentsOf: URL(string: truck.image)!) {
                let truckImage = UIImage(data: data as Data)
                
                let size = CGSize(width: 35, height: 35)
                UIGraphicsBeginImageContext(size)
                truckImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                
                let leftCalloutImageView = UIImageView(image: resizedImage)
                annotationView?.leftCalloutAccessoryView = leftCalloutImageView
            }
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
