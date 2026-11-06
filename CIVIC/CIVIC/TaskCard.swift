//
//  TaskCard.swift
//  CIVIC
//
//  Created by Pritish Sareen on 31/08/26.
//


import SwiftUI
import CoreLocation

struct TaskCard: View {
    
    let task: CivicTask
    let userLocation: CLLocation?
    
    var distanceText: String {
        
        guard let userLocation else {
            return "Nearby"
        }
        
        let taskLocation = CLLocation(
            latitude: task.latitude,
            longitude: task.longitude
        )
        
        let distance = userLocation.distance(
            from: taskLocation
        )
        
        if distance < 1000 {
            return "\(Int(distance)) m"
        } else {
            return String(
                format: "%.1f km",
                distance / 1000
            )
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 14) {
            
            // MARK: Title
            
            HStack(alignment: .top) {
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(task.title)
                        .font(.system(
                            size: 18,
                            weight: .semibold
                        ))
                        .foregroundStyle(CIVICTheme.text)
                    
                    Text(task.category)
                        .font(.system(
                            size: 12,
                            weight: .medium
                        ))
                        .foregroundStyle(CIVICTheme.primary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    
                    Text("₹\(Int(task.payment))")
                        .font(.system(
                            size: 18,
                            weight: .bold
                        ))
                        .foregroundStyle(CIVICTheme.primary)
                    
                    Text("payment")
                        .font(.system(size: 10))
                        .foregroundStyle(
                            CIVICTheme.secondaryText
                        )
                }
            }
            
            Divider()
            
            // MARK: Details
            
            HStack(spacing: 18) {
                
                Label(
                    distanceText,
                    systemImage: "mappin"
                )
                
                Label(
                    "\(task.duration) min",
                    systemImage: "clock"
                )
            }
            .font(.system(size: 12))
            .foregroundStyle(
                CIVICTheme.secondaryText
            )
        }
        .padding(18)
        .background(Color.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(
                    CIVICTheme.secondaryBackground,
                    lineWidth: 1
                )
        )
    }
}
