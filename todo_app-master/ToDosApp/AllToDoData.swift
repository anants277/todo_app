//
//  AllToDoData.swift
//  ToDos
//
//  Created by Creo Server on 19/12/19.
//  Copyright © 2019 Creo Server. All rights reserved.
//

import Foundation
struct AllToDoData: Codable
{
    static var allDataDict = [String: ToDoDataClass]()
    static var allData = [ToDoDataClass]()
}
