//
//  UserData+CoreDataProperties.swift
//  ToDosApp
//
//  Created by Creo Server on 20/12/19.
//  Copyright © 2019 Creo Server. All rights reserved.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData>
    {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged var toDoList: ToDoDataClass

}
