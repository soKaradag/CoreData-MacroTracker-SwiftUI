//
//  FavoritesView.swift
//  macroTracker
//
//  Created by Serdar Onur KARADAĞ on 8.09.2022.
//

import SwiftUI
import CoreData

struct FavoritesView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView{
            VStack {
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
            .navigationTitle("FAVORITES")
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

    
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
