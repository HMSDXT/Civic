//
//  FindTaskView.swift
//  CIVIC
//
//  Created by Pritish Sareen on 20/08/26.
//


import SwiftUI
import SwiftData
import CoreLocation

struct FindTaskView: View {
    
    @Query
    private var tasks: [CivicTask]
    
    @State private var userLocation: CLLocation?
    
    var body: some View {
        
        ZStack {
            
            CIVICTheme.background
                .ignoresSafeArea()
            
            if tasks.isEmpty {
                
                emptyState
                
            } else {
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // MARK: Header
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text("Find a Task")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundStyle(CIVICTheme.text)
                            
                            Text("Opportunities available near you.")
                                .font(.system(size: 14))
                                .foregroundStyle(CIVICTheme.secondaryText)
                        }
                        
                        Text("\(tasks.count) \(tasks.count == 1 ? "task" : "tasks") available")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(CIVICTheme.secondaryText)
                        
                        LazyVStack(spacing: 14) {
                            
                            ForEach(sortedTasks) { task in
                                
                                NavigationLink {
                                    TaskDetailView(task: task)
                                } label: {
                                    TaskCard(
                                        task: task,
                                        userLocation: userLocation
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(24)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await requestLocation()
        }
    }
    
    // MARK: Sorted Tasks
    
    private var sortedTasks: [CivicTask] {
        
        guard let userLocation else {
            return tasks.sorted { $0.date < $1.date }
        }
        
        return tasks.sorted {
            
            let firstLocation = CLLocation(
                latitude: $0.latitude,
                longitude: $0.longitude
            )
            
            let secondLocation = CLLocation(
                latitude: $1.latitude,
                longitude: $1.longitude
            )
            
            return firstLocation.distance(
                from: userLocation
            ) < secondLocation.distance(
                from: userLocation
            )
        }
    }
    
    // MARK: Location
    
    private func requestLocation() async {
        
        let manager = CLLocationManager()
        
        manager.requestWhenInUseAuthorization()
        
        if let location = manager.location {
            userLocation = location
        }
    }
    
    // MARK: Empty State
    
    private var emptyState: some View {
        
        VStack(spacing: 16) {
            
            Image(systemName: "magnifyingglass")
                .font(.system(size: 38, weight: .medium))
                .foregroundStyle(CIVICTheme.primary)
            
            Text("No tasks yet")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(CIVICTheme.text)
            
            Text("New opportunities will appear here when someone posts a task.")
                .font(.system(size: 14))
                .foregroundStyle(CIVICTheme.secondaryText)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 300)
        }
        .padding()
    }
}
