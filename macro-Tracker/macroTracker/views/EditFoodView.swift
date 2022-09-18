//
//  EditFoodView.swift
//  macroTracker
//
//  Created by Serdar Onur KARADAĞ on 31.08.2022.
//

import SwiftUI

struct EditFoodView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var food: FetchedResults<Food>.Element
    
    @State private var name = ""
    @State private var calorie: Double = 0
    @State private var carb: Double = 0
    @State private var protein: Double = 0
    
    var body: some View {
        Form{
            Section{
                TextField("\(food.name!)", text: $name)
                    .onAppear{
                        name = food.name!
                        calorie = food.calorie
                        carb = food.carb
                        protein = food.protein
                    }
                VStack{
                    Text("Calorie: \(Int(calorie))")
                    Slider(value: $calorie, in: 0...2000, step: 10)
                    
                }
                .padding()
                
                VStack{
                    Text("Protein: \(Int(protein))")
                    Slider(value: $protein, in: 0...200, step: 1)
                    
                }
                .padding()
                
                VStack{
                    Text("Carb: \(Int(carb))")
                    Slider(value: $carb, in: 0...200, step: 1)
                    
                }
                .padding()
                
                HStack{
                    Spacer()
                    Button("Submit"){
                        DataController().editFood(food: food, name: name, calorie: calorie, carb: protein, protein: carb, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

