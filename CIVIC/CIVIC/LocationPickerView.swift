//
//  LocationPickerView.swift
//  CIVIC
//
//  Created by Pritish Sareen on 01/09/26.
//


import SwiftUI
import MapKit
import CoreLocation

struct LocationPickerView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedLocation: String
    @Binding var selectedLatitude: Double
    @Binding var selectedLongitude: Double
    
    @State private var position: MapCameraPosition
    @State private var selectedCoordinate: CLLocationCoordinate2D
    
    init(
        selectedLocation: Binding<String>,
        selectedLatitude: Binding<Double>,
        selectedLongitude: Binding<Double>
    ) {
        self._selectedLocation = selectedLocation
        self._selectedLatitude = selectedLatitude
        self._selectedLongitude = selectedLongitude
        
        let coordinate = CLLocationCoordinate2D(
            latitude: selectedLatitude.wrappedValue == 0
                ? 30.9010
                : selectedLatitude.wrappedValue,
            longitude: selectedLongitude.wrappedValue == 0
                ? 75.8573
                : selectedLongitude.wrappedValue
        )
        
        _selectedCoordinate = State(initialValue: coordinate)
        _position = State(
            initialValue: .region(
                MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.04,
                        longitudeDelta: 0.04
                    )
                )
            )
        )
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            MapReader { proxy in
                
                Map(position: $position) {
                    
                    Marker(
                        "Task Location",
                        coordinate: selectedCoordinate
                    )
                }
                .mapStyle(.standard)
                .onTapGesture { screenPosition in
                    
                    if let coordinate = proxy.convert(
                        screenPosition,
                        from: .local
                    ) {
                        selectedCoordinate = coordinate
                        selectedLatitude = coordinate.latitude
                        selectedLongitude = coordinate.longitude
                        
                        reverseGeocode(coordinate)
                    }
                }
            }
            .ignoresSafeArea()
            
            // Bottom location card
            
            VStack(spacing: 14) {
                
                HStack {
                    
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(CIVICTheme.primary)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        
                        Text("Selected Location")
                            .font(.system(size: 12))
                            .foregroundStyle(CIVICTheme.secondaryText)
                        
                        Text(
                            selectedLocation.isEmpty
                            ? "Tap anywhere on the map"
                            : selectedLocation
                        )
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(CIVICTheme.text)
                        .lineLimit(2)
                    }
                    
                    Spacer()
                }
                
                Button {
                    dismiss()
                } label: {
                    
                    Text("Use This Location")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(CIVICTheme.primary)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 14)
                        )
                }
            }
            .padding(20)
            .background(.ultraThinMaterial)
            .clipShape(
                RoundedRectangle(cornerRadius: 24)
            )
            .padding(16)
        }
        .navigationTitle("Select Location")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func reverseGeocode(
        _ coordinate: CLLocationCoordinate2D
    ) {
        
        let location = CLLocation(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
        
        CLGeocoder().reverseGeocodeLocation(location) {
            placemarks,
            error in
            
            guard
                error == nil,
                let placemark = placemarks?.first
            else {
                return
            }
            
            let parts = [
                placemark.name,
                placemark.locality,
                placemark.administrativeArea
            ]
            .compactMap { $0 }
            
            DispatchQueue.main.async {
                selectedLocation = parts.joined(separator: ", ")
            }
        }
    }
}