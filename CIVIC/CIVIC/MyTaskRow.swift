//
//  MyTaskRow.swift
//  CIVIC
//
//  Created by Pritish Sareen on 01/09/26.
//


import SwiftUI

struct MyTaskRow: View {
    
    let task: CivicTask
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 14) {
            
            // MARK: Top
            
            HStack(alignment: .top) {
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(task.title)
                        .font(.system(
                            size: 17,
                            weight: .semibold
                        ))
                        .foregroundStyle(
                            CIVICTheme.text
                        )
                    
                    Text(task.category)
                        .font(.system(
                            size: 12,
                            weight: .medium
                        ))
                        .foregroundStyle(
                            CIVICTheme.primary
                        )
                }
                
                Spacer()
                
                Text("₹\(Int(task.payment))")
                    .font(.system(
                        size: 18,
                        weight: .bold
                    ))
                    .foregroundStyle(
                        CIVICTheme.primary
                    )
            }
            
            Divider()
            
            // MARK: Details
            
            HStack(spacing: 18) {
                
                Label(
                    "\(task.duration) min",
                    systemImage: "clock"
                )
                
                Label(
                    task.location,
                    systemImage: "mappin"
                )
                .lineLimit(1)
            }
            .font(.system(size: 12))
            .foregroundStyle(
                CIVICTheme.secondaryText
            )
            
            // MARK: Status
            
            HStack {
                
                Circle()
                    .fill(
                        task.isCompleted
                        ? CIVICTheme.primary
                        : task.isAccepted
                        ? Color.orange
                        : Color.gray
                    )
                    .frame(width: 7, height: 7)
                
                Text(statusText)
                    .font(.system(
                        size: 11,
                        weight: .medium
                    ))
                    .foregroundStyle(
                        CIVICTheme.secondaryText
                    )
                
                Spacer()
                
                Text("Swipe to delete")
                    .font(.system(size: 10))
                    .foregroundStyle(
                        CIVICTheme.secondaryText.opacity(0.7)
                    )
            }
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
    
    private var statusText: String {
        
        if task.isCompleted {
            return "Completed"
        }
        
        if task.isAccepted {
            return "Accepted"
        }
        
        return "Open"
    }
}