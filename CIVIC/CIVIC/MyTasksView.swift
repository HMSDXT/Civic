//
//  MyTasksView.swift
//  CIVIC
//
//  Created by Pritish Sareen on 01/09/26.
//


import SwiftUI
import SwiftData

struct MyTasksView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \CivicTask.date)
    private var tasks: [CivicTask]
    
    var body: some View {
        
        ZStack {
            
            CIVICTheme.background
                .ignoresSafeArea()
            
            if tasks.isEmpty {
                
                emptyState
                
            } else {
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 22) {
                        
                        // MARK: Header
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text("My Tasks")
                                .font(.system(
                                    size: 30,
                                    weight: .bold
                                ))
                                .foregroundStyle(CIVICTheme.text)
                            
                            Text("Tasks you've posted on CIVIC.")
                                .font(.system(size: 14))
                                .foregroundStyle(
                                    CIVICTheme.secondaryText
                                )
                        }
                        
                        // MARK: Task count
                        
                        Text(
                            "\(tasks.count) \(tasks.count == 1 ? "task" : "tasks")"
                        )
                        .font(.system(
                            size: 13,
                            weight: .medium
                        ))
                        .foregroundStyle(
                            CIVICTheme.secondaryText
                        )
                        
                        // MARK: Tasks
                        
                        LazyVStack(spacing: 14) {
                            
                            ForEach(tasks) { task in
                                
                                MyTaskRow(task: task)
                                    .contextMenu {
                                        
                                        Button {
                                            deleteTask(task)
                                        } label: {
                                            Label(
                                                "Delete Task",
                                                systemImage: "trash"
                                            )
                                        }
                                        .tint(.red)
                                    }
                                    .swipeActions(
                                        edge: .trailing,
                                        allowsFullSwipe: false
                                    ) {
                                        
                                        Button(role: .destructive) {
                                            deleteTask(task)
                                        } label: {
                                            Label(
                                                "Delete",
                                                systemImage: "trash"
                                            )
                                        }
                                    }
                            }
                        }
                    }
                    .padding(24)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Empty State
    
    private var emptyState: some View {
        
        VStack(spacing: 16) {
            
            Image(systemName: "list.bullet.clipboard")
                .font(.system(size: 40))
                .foregroundStyle(CIVICTheme.primary)
            
            Text("No tasks posted")
                .font(.system(
                    size: 22,
                    weight: .bold
                ))
                .foregroundStyle(CIVICTheme.text)
            
            Text(
                "Tasks you post will appear here."
            )
            .font(.system(size: 14))
            .foregroundStyle(
                CIVICTheme.secondaryText
            )
            .multilineTextAlignment(.center)
            
        }
        .padding()
    }
    
    // MARK: Delete
    
    private func deleteTask(_ task: CivicTask) {
        
        modelContext.delete(task)
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to delete task: \(error)")
        }
    }
}