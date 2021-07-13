//
//  MapViewController.swift
//  BabckBaseTest
//
//  Created by Lakshminaidu on 10/7/21.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var viewModel: MapDetailViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.city?.title
        setRegion()
    }
    
    func setRegion() {
        if let region = viewModel.region {
            mapView.setRegion(region, animated: true)
        }
        
        if let pin = viewModel.mapPin() {
            mapView.addAnnotation(pin)
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    /// annotion view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Artwork else {
            return nil
        }
        let identifier = "artwork"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier)
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
