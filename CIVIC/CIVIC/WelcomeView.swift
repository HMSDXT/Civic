import SwiftUI

struct WelcomeView: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
        
        ZStack {
            
            CIVICTheme.background
                .ignoresSafeArea()
            
            VStack(spacing: 0)  {
                    
                    Spacer()
                    
                    // MARK: Logo
                    
                    VStack(spacing: 12) {
                        
                        ZStack {
                            Circle()
                                .fill(CIVICTheme.secondaryBackground)
                                .frame(width: 82, height: 82)
                            
                            Image(systemName: "heart.fill")
                                .font(.system(size: 32))
                                .foregroundStyle(CIVICTheme.primary)
                        }
                        
                        Text("CIVIC")
                            .font(
                                .system(
                                    size: 38,
                                    weight: .bold,
                                    design: .rounded
                                )
                            )
                            .tracking(5)
                            .foregroundStyle(CIVICTheme.text)
                        
                        Text("Small tasks. Big impact.")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(CIVICTheme.secondaryText)
                    }
                    
                    Spacer()
                        .frame(height: 55)
                    
                    // MARK: Question
                    
                    Text("What would you like to do?")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(CIVICTheme.text)
                    
                    Spacer()
                        .frame(height: 22)
                    
                    // MARK: Post Task
                    
                Button {
                    selectedTab = 1
                } label: {
                    HomeOptionCard(
                        icon: "plus",
                        title: "POST A TASK",
                        subtitle: "Need someone nearby to help?"
                    )
                }
                .buttonStyle(.plain)
                    
                    // MARK: Find Task
                    
                Button {
                    selectedTab = 2
                } label: {
                    HomeOptionCard(
                        icon: "magnifyingglass",
                        title: "FIND A TASK",
                        subtitle: "Earn by helping people nearby."
                    )
                }
                .buttonStyle(.plain)
                    
                    Spacer()
                    
                    Text("Get things done. Help people nearby.")
                        .font(.system(size: 12))
                        .foregroundStyle(CIVICTheme.secondaryText)
                        .padding(.bottom, 20)
                }
                .padding(.horizontal, 24)
            }
            .navigationBarHidden(true)
        }
    }



// MARK: - Home Option Card

struct HomeOptionCard: View {
    
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            ZStack {
                Circle()
                    .fill(CIVICTheme.secondaryBackground)
                    .frame(width: 58, height: 58)
                
                Image(systemName: icon)
                    .font(.system(size: 23, weight: .medium))
                    .foregroundStyle(CIVICTheme.primary)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(CIVICTheme.primary)
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(CIVICTheme.secondaryText)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(CIVICTheme.secondaryText)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(
                    CIVICTheme.secondaryBackground,
                    lineWidth: 1
                )
        )
        .padding(.bottom, 12)
    }
}
