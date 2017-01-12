//
//  DatabaseContoller.swift
//  Facebook Chat
//
//  Created by mohsin raza on 11/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import Foundation
import CoreData

class DatabaseController
{
    
    private init(){}
    
    
    class func getContext()->NSManagedObjectContext
    {
      return persistentContainer.viewContext
    }
    
    
    // MARK: - Core Data stack
    
     static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Facebook_Chat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError?
            {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    class func saveContext ()
    {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do
            {
                try context.save()
            }
            catch
            {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


