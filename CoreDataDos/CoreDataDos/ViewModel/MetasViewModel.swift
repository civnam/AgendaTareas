//
//  MetasViewModel.swift
//  CoreDataDos
//
//  Created by MAC on 06/08/22.
//

import Foundation
import CoreData

class MetasViewModel: ObservableObject {
    
    @Published var titulo = ""
    @Published var desc = ""
    
    func saveData(context: NSManagedObjectContext) {
        let newMeta = Metas(context: context)
        newMeta.titulo = titulo
        newMeta.desc = desc
        newMeta.id = UUID().uuidString
        
        do {
            try context.save()
            print("Guardo")
        } catch let error as NSError {
            print("No guardo", error.localizedDescription)
        }
    }
    
    func deleteData(item: Metas, context: NSManagedObjectContext) {
        context.delete(item)
        
        do {
            try context.save()
            print("Elimino")
        } catch let error as NSError {
            print("No elimino", error.localizedDescription)
        }
    }
    
}
