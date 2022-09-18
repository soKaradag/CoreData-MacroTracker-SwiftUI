//
//  ContentView.swift
//  macroTracker
//
//  Created by Serdar Onur KARADAĞ on 31.08.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var showingAddView = false
    
    
    var body: some View {
        NavigationView{
            
            VStack(alignment: .leading){
                
                Text("\(Int(totalCaloriesToday())) KCal (Today)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                Text("\(Int(totalCarbsToday())) gr Carb (Today)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                Text("\(Int(totalProteinToday())) gr Protein (Today)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                
                List{
                    ForEach(food) { food in
                        NavigationLink(destination: EditFoodView(food: food)){
                            
                            HStack{
                                VStack(alignment: .leading, spacing: 6){
                                    Text(food.name!)
                                        .bold()
                                    HStack {
                                        Text("\(Int(food.calorie))") + Text(" Cal").foregroundColor(.red)
                                        Text("\(Int(food.carb))") + Text(" Carb").foregroundColor(.red)
                                        Text("\(Int(food.protein))") + Text(" Pro").foregroundColor(.red)
                                    }.font(.system(size:16))
                                }
                                Spacer()
                                Text(calcTimeSince(date: food.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                            
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }
            .navigationTitle("MACRO TRACKER")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showingAddView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView){
                AddFoodView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteFood(offsets: IndexSet){
        withAnimation{
            offsets.map{ food[$0] }.forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
            
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
