//
//  MapView.swift
//  epoha.io
//
//  Created by constantine kos on 16.08.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var postDetails: News
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 47.920827, longitude: 33.396696)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        let annotation = MKPointAnnotation()
        annotation.title = self.postDetails.keyword
        annotation.coordinate = coordinate
        
        uiView.setRegion(region, animated: true)
        uiView.addAnnotation(annotation)
        
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}




struct Landmark: Hashable, Decodable {
    var coordinates: Coordinates

    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
}
    

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
