//
//  DataController.swift
//  macroTracker
//
//  Created by Serdar Onur KARADAĞ on 31.08.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "DataModel")
    
    init(){
        container.loadPersistentStores{ desc, error in
            if let error = error {
                print("Failed to load data.\(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data saved")
        } catch{
            print("Data could not save.")
        }
    }
    
    func addFood(name: String, calorie: Double, carb: Double, protein: Double, context:NSManagedObjectContext){
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calorie = calorie
        food.carb = carb
        food.protein = protein
        
        save(context: context)
    }
    
    func editFood(food: Food, name: String, calorie: Double, carb: Double, protein: Double, context:NSManagedObjectContext){
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calorie = calorie
        food.carb = carb
        food.protein = protein
        
        save(context: context)
    }
    
    
}
