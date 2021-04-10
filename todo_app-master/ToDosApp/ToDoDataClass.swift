//
//  ToDoDataClass.swift
//  ToDosApp
//
//  Created by Creo Server on 20/12/19.
//  Copyright © 2019 Creo Server. All rights reserved.
//

import Foundation
class ToDoDataClass: NSObject , NSCoding
{
    func encode(with coder: NSCoder)
    {
        coder.encode(data, forKey: "name")
        coder.encode(cutdata, forKey: "cutdata")
        coder.encode(tableName, forKey: "tableName")
    }
    
    required init?(coder: NSCoder)
    {
        data = coder.decodeObject(forKey: "name") as? [String] ?? []
        cutdata = coder.decodeObject(forKey: "cutdata") as? [Bool] ?? []
        tableName = coder.decodeObject(forKey: "tableName") as? String ?? ""
    }
    

    
    var data : [String]
    var cutdata : [Bool]
    var tableName : String
    
    init(data: [String], cutdata: [Bool], tableNane: String)
    {
        self.data = data
        self.cutdata = cutdata
        self.tableName = tableNane
    }
}
