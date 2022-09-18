//
//  AddFoodView.swift
//  macroTracker
//
//  Created by Serdar Onur KARADAĞ on 31.08.2022.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calorie: Double = 0
    @State private var carb: Double = 0
    @State private var protein: Double = 0
    
    var body: some View {
        Form{
            Section{
                TextField("Food Name", text: $name)
                
                VStack{
                    Text("Calorie: \(Int(calorie))")
                    Slider(value: $calorie, in: 0...2000, step: 10)
                }
                .padding()
                
                Section{
                    
                    VStack{
                        Text("Protein: \(Int(protein))")
                        Slider(value: $protein, in: 0...200, step: 1)
                    }
                    .padding()
                }
                
                Section{
                    
                    VStack{
                        Text("Carb: \(Int(carb))")
                        Slider(value: $carb, in: 0...200, step: 1)
                    }
                    .padding()
                }
                
                
                HStack{
                    Spacer()
                    Button("Susbmit"){
                        DataController().addFood(name: name, calorie: calorie, carb: carb, protein: protein, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
