//
//  CIVICActionCard.swift
//  CIVIC
//
//  Created by Pritish Sareen on 20/08/26.
//


import SwiftUI

struct CIVICActionCard: View {
    
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        
        HStack(spacing: 18) {
            
            // Icon
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(CIVICTheme.secondaryBackground)
                    .frame(width: 58, height: 58)
                
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(CIVICTheme.primary)
            }
            
            // Text
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(CIVICTheme.text)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(CIVICTheme.secondaryText)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(CIVICTheme.secondaryText)
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    CIVICTheme.secondaryBackground,
                    lineWidth: 1
                )
        )
        .padding(.bottom, 12)
    }
}