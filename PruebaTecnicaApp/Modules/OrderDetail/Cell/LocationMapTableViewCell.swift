//
//  LocationMapTableViewCell.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 17/04/21.
//

import UIKit
import MapKit

protocol LocationMapTableViewCellDelegate: class {
    func didSelectAddressInMap(storeName: String)
}

class LocationMapTableViewCell: UITableViewCell {

    @IBOutlet private weak var mapView: MKMapView!
    
    weak var delegate: LocationMapTableViewCellDelegate?
    let locationManager = CLLocationManager()
    
    var defaultCoordinates = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.stopUpdatingLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
        mapView.delegate = self
    }
    
    func configureMap(user: UserResult) {
        defaultCoordinates = CLLocationCoordinate2D(latitude: (Double(user.location?.coordinates?.latitude ?? "") ?? 0.0), longitude: (Double(user.location?.coordinates?.longitude ?? "") ?? 0.0))
        let userLocation = CLLocationCoordinate2D(latitude: defaultCoordinates.latitude, longitude: defaultCoordinates.longitude)
        let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 20000, longitudinalMeters: 20000)
        mapView.setRegion(viewRegion, animated: true)
        mapView.showsUserLocation = false
        let userAddress = MKPointAnnotation()
        userAddress.coordinate = CLLocationCoordinate2D(latitude: (Double(user.location?.coordinates?.latitude ?? "") ?? 0.0), longitude: (Double(user.location?.coordinates?.longitude ?? "") ?? 0.0))
        userAddress.title = "\(user.location?.street?.name ?? "") \(user.location?.street?.number ?? 0), \(user.location?.city ?? "")"
        mapView.addAnnotation(userAddress)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension LocationMapTableViewCell : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        annotationView.image =  Icons.TabBarItems.accepted
        annotationView.canShowCallout = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotationTitle = view.annotation?.title, let addressTitle = annotationTitle else { return }
    }
}

extension LocationMapTableViewCell : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.defaultCoordinates = CLLocationCoordinate2D()
            print("Found user's location: \(location)")
        }
    }
}
