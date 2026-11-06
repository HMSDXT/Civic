//
//  MainTabView.swift
//  CIVIC
//
//  Created by Pritish Sareen on 01/09/26.
//


import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            // MARK: Home
            
            WelcomeView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            
            // MARK: Post Task
            
            NavigationStack {
                PostTaskView()
            }
            .tabItem {
                Label("Post", systemImage: "plus.circle")
            }
            .tag(1)
            
            
            // MARK: Find Task
            
            NavigationStack {
                FindTaskView()
            }
            .tabItem {
                Label("Find", systemImage: "magnifyingglass")
            }
            .tag(2)
            
            
            // MARK: My Tasks
            
            NavigationStack {
                MyTasksView()
            }
            .tabItem {
                Label("My Tasks", systemImage: "list.bullet")
            }
            .tag(3)
        }
        .tint(CIVICTheme.primary)
    }
}