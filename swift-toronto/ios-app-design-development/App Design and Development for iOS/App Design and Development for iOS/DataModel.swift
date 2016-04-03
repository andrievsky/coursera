//
//  DataModel.swift
//  App Design and Development for iOS
//
//  Created by Nick Andrievsky on 4/3/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//

import Foundation
import CoreData

public class DataModel {
    
    static private let instance = DataModel()
    
    static public func getInstance() -> DataModel {
        return instance!
    }
    
    let managedObjectContext: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.managedObjectContext = moc
    }
    
    convenience init?() {
        
        guard let modelURL = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd") else {
            return nil
        }
        
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            return nil
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        moc.persistentStoreCoordinator = psc
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let persistantStoreFileURL = urls[0].URLByAppendingPathComponent("Images.sqlite")
        
        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: persistantStoreFileURL, options: nil)
        } catch {
            fatalError("Error adding store.")
        }
        
        self.init(moc: moc)
        
        
    }
    
    func loadImages() -> [Image] {
        let imagesFetch = NSFetchRequest(entityName: "Image")
        //imagesFetch.predicate = NSPredicate(format: "title == %@", tagTitle)
        
        var fetchedImages: [Image]!
        do {
            fetchedImages = try self.managedObjectContext.executeFetchRequest(imagesFetch) as! [Image]
        } catch {
            fatalError("fetch failed")
        }
        
        if fetchedImages.count == 0 {
            return []
//            image = NSEntityDescription.insertNewObjectForEntityForName("Tag", inManagedObjectContext: self.managedObjectContext) as! Tag
//            image.title = tagTitle
        } else {
            return fetchedImages
        }
        
        
    }
    
    func save(source:NSData, comment:String) {
        let newImage = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: self.managedObjectContext) as! Image
        
        newImage.sourse = source
        newImage.comment = comment
        
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't save context")
        }
    }
}
