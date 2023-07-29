//
//  CoreDataBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 20/07/2023.
//

import SwiftUI
import CoreData




// View - UI
// Model - data point
// ViewModel - manages the data for a view


class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init () {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("SUCCESSFULLY LOADED CORE DATA")
            }
            
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
           savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
        
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
        
    }
    
    func updateFruit(entity: FruitEntity){
        let currentName = entity.name ?? ""
        
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else  {return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        
        do {
           try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving. \(error)")
        }
        
        
    }
}


struct CoreDataBootcamp: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textfieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add fruit here . . . ", text: $textfieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    guard !textfieldText.isEmpty else { return }
                    vm.addFruit(text: textfieldText)
                }, label: {
                    Text("Add Fruit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height:55)
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.5))
                        .cornerRadius(10)
                })
                .padding(.horizontal)
                
                
                List {
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "No name")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }

                    }
                    .onDelete(perform: vm.deleteFruit)
                    .listStyle(PlainListStyle())
                }
                
                
                Spacer()
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
