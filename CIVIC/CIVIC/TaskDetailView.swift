//
//  TaskDetailView.swift
//  CIVIC
//
//  Created by Pritish Sareen on 31/08/26.
//


import SwiftUI

struct TaskDetailView: View {
    
    let task: CivicTask
    
    var body: some View {
        
        ZStack {
            
            CIVICTheme.background
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: Header
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text(task.title)
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(CIVICTheme.text)
                        
                        Text(task.category)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(CIVICTheme.primary)
                    }
                    
                    // MARK: Payment
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Payment")
                                .font(.system(size: 12))
                                .foregroundStyle(CIVICTheme.secondaryText)
                            
                            Text("₹\(Int(task.payment))")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(CIVICTheme.primary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("Duration")
                                .font(.system(size: 12))
                                .foregroundStyle(CIVICTheme.secondaryText)
                            
                            Text("\(task.duration) min")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(CIVICTheme.text)
                        }
                    }
                    .padding(18)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    
                    // MARK: Description
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("About this task")
                            .font(.headline)
                            .foregroundStyle(CIVICTheme.text)
                        
                        Text(task.taskDescription)
                            .font(.system(size: 15))
                            .foregroundStyle(CIVICTheme.secondaryText)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    // MARK: Location
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Location")
                            .font(.headline)
                            .foregroundStyle(CIVICTheme.text)
                        
                        HStack {
                            
                            Image(systemName: "mappin.circle.fill")
                                .foregroundStyle(CIVICTheme.primary)
                            
                            Text(task.location)
                                .font(.system(size: 15))
                                .foregroundStyle(CIVICTheme.text)
                        }
                    }
                    
                    // MARK: Date
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("When")
                            .font(.headline)
                            .foregroundStyle(CIVICTheme.text)
                        
                        Text(
                            task.date.formatted(
                                date: .abbreviated,
                                time: .shortened
                            )
                        )
                        .font(.system(size: 15))
                        .foregroundStyle(CIVICTheme.secondaryText)
                    }
                    
                    // MARK: Accept
                    
                    Button {
                        task.isAccepted = true
                    } label: {
                        
                        Text(
                            task.isAccepted
                            ? "Task Accepted"
                            : "Accept Task"
                        )
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            task.isAccepted
                            ? CIVICTheme.secondaryText
                            : CIVICTheme.primary
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 14)
                        )
                    }
                    .disabled(task.isAccepted)
                }
                .padding(24)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}