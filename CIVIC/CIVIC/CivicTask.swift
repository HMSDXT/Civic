//
//  CivicTask.swift
//  CIVIC
//
//  Created by Pritish Sareen on 31/08/26.
//


import Foundation
import SwiftData

@Model
final class CivicTask {
    
    var title: String
    var taskDescription: String
    var category: String
    var date: Date
    
    // Location
    var location: String
    var latitude: Double
    var longitude: Double
    
    var payment: Double
    var duration: Int
    
    var isCompleted: Bool
    var isAccepted: Bool
    
    init(
        title: String,
        taskDescription: String,
        category: String,
        date: Date,
        location: String,
        latitude: Double,
        longitude: Double,
        payment: Double,
        duration: Int
    ) {
        self.title = title
        self.taskDescription = taskDescription
        self.category = category
        self.date = date
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
        self.payment = payment
        self.duration = duration
        self.isCompleted = false
        self.isAccepted = false
    }
}
