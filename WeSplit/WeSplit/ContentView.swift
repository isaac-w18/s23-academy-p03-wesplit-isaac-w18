//
//  ContentView.swift
//  WeSplit
//
//  Created by Isaac Frank on 2/16/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount",
                              value: $checkAmount,
                              format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    TextField("Tip percentage", value: $tipPercentage, format: .percent)
                } header : {
                    Text("Enter amount and tip percentage")
                }
                
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Text(checkAmount + (checkAmount * Double(tipPercentage)), format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Check Total with Tip:")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }  header: {
                    Text("Total per person:")
                }
            }
            .navigationTitle("WeSplit")
            
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 Form {
     Picker("Select your student", selection: $selectedStudent) {
         ForEach(students, id: \.self/* telling SwiftUI that every string is unique*/) {
             Text($0)
         }
     }
 }
 */
