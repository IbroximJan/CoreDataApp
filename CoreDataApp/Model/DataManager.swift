//
//  DataManager.swift
//  CoreDataApp
//
//  Created by Ibrohimjon on 24/01/2022.
//

import UIKit
import CoreData

class DataManager {
    static let shared = DataManager()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func fetched() -> [Notes] {
        let request: NSFetchRequest <Notes> = Notes.fetchRequest()
        var fetchData: [Notes] = []
        do {
            fetchData = try persistentContainer.viewContext.fetch(request)
            
        }catch {
            print("Error")
        }
        return fetchData
    }
    
    func notes(quote: String) -> Notes  {
        let note = Notes(context: persistentContainer.viewContext)
        note.quote = quote
        
        return note
    }
    
    // MARK: - Core Data Saving support

    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteNotes(_ task: Notes) -> Bool {
//        persistentContainer.viewContext.delete(task)
        
        do {
            try persistentContainer.viewContext.delete(task)
        } catch  {
            print(error)

            return false
        }
        
        return true
    }


}
