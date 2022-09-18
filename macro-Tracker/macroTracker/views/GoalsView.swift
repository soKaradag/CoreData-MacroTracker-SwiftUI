//
//  ListView.swift
//  macroTracker
//
//  Created by Serdar Onur KARADAĞ on 31.08.2022.
//

import SwiftUI
import CoreData

struct GoalsView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @AppStorage("GoalCalorie") var goalCal:Double = 2000
    @AppStorage("GoalCarb") var goalCarb:Double = 100
    @AppStorage("GoalPro") var goalPro:Double = 150
    
    
    
    var body: some View {
        
        VStack(alignment: .center) {
            

            
            
            ZStack {
                
                
                VStack (alignment: .leading){
                        
                        Text("TODAY'S GOALS")
                            .font(.system(size:30, weight: .semibold))
                            .padding(.leading, 10)
                        
                        VStack(alignment: .leading){
                            HStack() {
                                Text("Goal Calories:")
                                TextField("Goal Cal", value: $goalCal, format: .number)
                                    .frame(width: 75, height: 30)
                                    .textFieldStyle(.roundedBorder)
                            }
                            Text("\(Int(percCal() / 2))% Cal Complated Today")
                            ZStack(alignment: .leading){
                                Rectangle()
                                    .cornerRadius(25)
                                    .foregroundColor(Color.black.opacity(0.1))
                                    .frame(width: 200, height: 15)
                                Rectangle()
                                    .cornerRadius(25)
                                    .foregroundColor(Color.blue.opacity(0.6))
                                    .frame(width: percCal(), height: 15)
                            }
                        }.padding()
                        
                        VStack(alignment: .leading){
                            HStack {
                                Text("Goal Carb:")
                                TextField("Goal Carb", value: $goalCarb, format: .number)
                                    .frame(width: 50, height: 30)
                                    .textFieldStyle(.roundedBorder)
                            }
                            Text("\(Int(percCarb() / 2))% Carb Complated Today")
                            ZStack(alignment: .leading){
                                Rectangle()
                                    .cornerRadius(25)
                                    .foregroundColor(Color.black.opacity(0.1))
                                    .frame(width: 200, height: 15)
                                Rectangle()
                                    .cornerRadius(25)
                                    .foregroundColor(Color.blue.opacity(0.6))
                                    .frame(width: percCarb(), height: 15)
                            }
                        }.padding()
                        
                        VStack(alignment: .leading){
                            HStack() {
                                Text("Goal Protein:")
                                TextField("Goal Protein", value: $goalPro, format: .number)
                                    .frame(width: 50, height: 30)
                                    .textFieldStyle(.roundedBorder)
                            }
                            Text("\(Int(percPro() / 2))% Pro Complated Today")
                            ZStack(alignment: .leading){
                                Rectangle()
                                    .cornerRadius(25)
                                    .foregroundColor(Color.black.opacity(0.1))
                                    .frame(width: 200, height: 15)
                                Rectangle()
                                    .cornerRadius(25)
                                    .foregroundColor(Color.blue.opacity(0.6))
                                    .frame(width: percPro(), height: 15)
                            }
                        }.padding()

                }
            }
            

                Spacer()
                VStack(alignment: .leading){
                    
                    Text("Your missing macros for today:")
                        .padding(1)
                    Text("Calories: \(Int(goalCal - totalCaloriesToday()))")
                        .padding(1)
                    Text("Carbs: \(Int(goalCarb - totalCarbsToday()))")
                        .padding(1)
                    Text("Proteins: \(Int(goalPro - totalProteinToday()))")
                        .padding(1)
                    
                }.padding()
                
            Spacer()
        }.padding(.top, 50)
        
        
        
    }
    
    func percCal() -> Double {
        
        var percentCalTod: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                if totalCaloriesToday() <= goalCal {
                    percentCalTod = ((totalCaloriesToday() * 100) / goalCal) * 2
                } else {
                    percentCalTod = 200
               
                }
            }
        }
        return percentCalTod
        
        
    }
    
    
    
    func percCarb() -> Double {
        
        var percentCarbTod: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                if totalCarbsToday() < goalCarb {
                    percentCarbTod = ((totalCarbsToday() * 100) / goalCarb) * 2
                } else {
                    percentCarbTod = 200
                }
            }
        }
        return percentCarbTod
    }
    
    func percPro() -> Double {
        
        var percentProTod: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                if totalProteinToday() <= goalPro {
                    percentProTod = ((totalProteinToday() * 100) / goalPro) * 2
                } else {
                    percentProTod = 200
                }
            }
        }
        return percentProTod
    }

    
    
    func totalCaloriesToday() -> Double {
        var caloriesToday: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                caloriesToday += item.calorie
            }
        }
        return caloriesToday
    }
    
    func totalCarbsToday() -> Double {
        var carbsToday: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                carbsToday += item.carb
            }
        }
        return carbsToday
    }
    
    func totalProteinToday() -> Double {
        var proteinToday: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                proteinToday += item.protein
            }
        }
        return proteinToday
    }
    

    
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
    }
}
