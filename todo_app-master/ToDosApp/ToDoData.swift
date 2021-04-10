//
//  ToDoData.swift
//  ToDos
//
//  Created by Creo Server on 17/12/19.
//  Copyright © 2019 Creo Server. All rights reserved.
//

import Foundation
struct ToDoData: Codable
{
    var data = ["#","#"]
    var cutdata = [false,false]
    var tableName = ""
    
    init()
    {
        
    }
    
    mutating func insertAtBeg(newData: String)
    {
        let endIndex = data.count-1
        data.append("#")
        cutdata.append(false)
        for index in stride(from: endIndex, to: 1, by: -1)
        {
            data[index+1] = data[index]
            data[index] = data[index-1]
            cutdata[index+1] = cutdata[index]
            cutdata[index] = cutdata[index-1]
        }
        data[1] = newData
        cutdata[1] = false
    }
    
    mutating func insertAtEnd(newData: String)
    {
        let endcutIndex = cutdata.count-1
        let endIndex = data.count-1
        data.append("#")
        cutdata.append(false)
        data[endIndex+1] = data[endIndex]
        data[endIndex] = newData
        cutdata[endcutIndex+1] = cutdata[endcutIndex]
        cutdata[endcutIndex] = false
    }
    
    
}

