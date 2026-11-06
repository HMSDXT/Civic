//
//  PostTaskView.swift
//  CIVIC
//
//  Created by Pritish Sareen on 20/08/26.
//


import SwiftUI
import SwiftData

struct PostTaskView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var title = ""
    @State private var taskDescription = ""
    @State private var category = "General"
    @State private var date = Date()
    @State private var location = ""
    @State private var latitude = 0.0
    @State private var longitude = 0.0
    @State private var payment = ""
    @State private var duration = 30
    
    @State private var showSuccess = false
    
    let categories = [
        "General",
        "Pet Care",
        "Errands",
        "Household",
        "Moving Help",
        "Community",
        "Tutoring",
        "Other"
    ]
    
    var body: some View {
        
        ZStack {
            
            CIVICTheme.background
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: Header
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text("Post a Task")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(CIVICTheme.text)
                        
                        Text("Tell people nearby what you need help with.")
                            .font(.system(size: 14))
                            .foregroundStyle(CIVICTheme.secondaryText)
                    }
                    
                    // MARK: Task Information
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text("Task Information")
                            .font(.headline)
                            .foregroundStyle(CIVICTheme.text)
                        
                        TextField("Task title", text: $title)
                            .textFieldStyle(CIVICTextFieldStyle())
                        
                        ZStack(alignment: .topLeading) {
                            
                            if taskDescription.isEmpty {
                                Text("Describe what needs to be done...")
                                    .foregroundStyle(Color.gray.opacity(0.6))
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 14)
                            }
                            
                            TextEditor(text: $taskDescription)
                                .frame(height: 110)
                                .scrollContentBackground(.hidden)
                                .padding(8)
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(
                                    CIVICTheme.secondaryBackground,
                                    lineWidth: 1
                                )
                        )
                        
                        Picker("Category", selection: $category) {
                            ForEach(categories, id: \.self) { category in
                                Text(category)
                                    .tag(category)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 4)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    
                    // MARK: Date & Time
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text("When")
                            .font(.headline)
                            .foregroundStyle(CIVICTheme.text)
                        
                        DatePicker(
                            "Date & Time",
                            selection: $date,
                            in: Date()...
                        )
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    
                    // MARK: Location

                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text("Location")
                            .font(.headline)
                            .foregroundStyle(CIVICTheme.text)
                        
                        NavigationLink {
                            LocationPickerView(
                                selectedLocation: $location,
                                selectedLatitude: $latitude,
                                selectedLongitude: $longitude
                            )
                        } label: {
                            
                            HStack(spacing: 14) {
                                
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(CIVICTheme.secondaryBackground)
                                        .frame(width: 52, height: 52)
                                    
                                    Image(systemName: "mappin")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundStyle(CIVICTheme.primary)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    
                                    Text(
                                        location.isEmpty
                                        ? "Select task location"
                                        : location
                                    )
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundStyle(
                                        location.isEmpty
                                        ? CIVICTheme.secondaryText
                                        : CIVICTheme.text
                                    )
                                    .lineLimit(2)
                                    
                                    Text("Choose a location on the map")
                                        .font(.system(size: 11))
                                        .foregroundStyle(CIVICTheme.secondaryText)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(CIVICTheme.secondaryText)
                            }
                            .padding(14)
                            .background(Color.white)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 14)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(
                                        CIVICTheme.secondaryBackground,
                                        lineWidth: 1
                                    )
                            )
                        }
                    }
                    
                    // MARK: Duration
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text("Duration")
                            .font(.headline)
                            .foregroundStyle(CIVICTheme.text)
                        
                        Picker("Duration", selection: $duration) {
                            Text("30 minutes").tag(30)
                            Text("45 minutes").tag(45)
                            Text("60 minutes").tag(60)
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    // MARK: Payment
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text("Payment")
                            .font(.headline)
                            .foregroundStyle(CIVICTheme.text)
                        
                        HStack {
                            
                            Text("₹")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(CIVICTheme.primary)
                            
                            TextField(
                                "Enter amount",
                                text: $payment
                            )
                            .keyboardType(.decimalPad)
                        }
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(
                                    CIVICTheme.secondaryBackground,
                                    lineWidth: 1
                                )
                        )
                    }
                    
                    // MARK: Post Button
                    
                    Button {
                        saveTask()
                    } label: {
                        
                        Text("Post Task")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(CIVICTheme.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1 : 0.5)
                    
                    Spacer(minLength: 20)
                }
                .padding(24)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Task Posted", isPresented: $showSuccess) {
            Button("OK") { }
        } message: {
            Text("Your task has been added to CIVIC.")
        }
    }
    
    // MARK: Validation
    
    private var formIsValid: Bool {
        
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !taskDescription.trimmingCharacters(in: .whitespaces).isEmpty &&
        !location.trimmingCharacters(in: .whitespaces).isEmpty &&
        latitude != 0 &&
        longitude != 0 &&
        Double(payment) != nil &&
        Double(payment)! > 0
    }
    
    // MARK: Save Task
    
    private func saveTask() {
        
        guard let paymentAmount = Double(payment) else {
            return
        }
        
        let newTask = CivicTask(
            title: title,
            taskDescription: taskDescription,
            category: category,
            date: date,
            location: location,
            latitude: latitude,
            longitude: longitude,
            payment: paymentAmount,
            duration: duration
        )
        
        modelContext.insert(newTask)
        
        do {
            try modelContext.save()
            showSuccess = true
            
        } catch {
            print("Failed to save task: \(error)")
        }
    }
}


// MARK: - Text Field Style

struct CIVICTextFieldStyle: TextFieldStyle {
    
    func _body(
        configuration: TextField<Self._Label>
    ) -> some View {
        
        configuration
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(
                        CIVICTheme.secondaryBackground,
                        lineWidth: 1
                    )
            )
    }
}
