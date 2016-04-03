//
//  Image+CoreDataProperties.swift
//  App Design and Development for iOS
//
//  Created by Nick Andrievsky on 4/3/16.
//  Copyright © 2016 Nick Andrievsky. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Image {

    @NSManaged var sourse: NSData?
    @NSManaged var comment: String?

}
