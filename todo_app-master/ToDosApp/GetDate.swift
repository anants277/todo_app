//
//  GetDate.swift
//  ToDosApp
//
//  Created by Creo Server on 23/12/19.
//  Copyright © 2019 Creo Server. All rights reserved.
//

import Foundation
class GetDate
{
    var rightNow = Date()
    var calendar = Calendar.current
    lazy var dateComponentForPresentDate = calendar.dateComponents([.year, .month, .day , .hour, .minute], from: rightNow)
    
    func timeString() -> String
    {
        let day = dateComponentForPresentDate.day!
        let month = dateComponentForPresentDate.month!
        let year = dateComponentForPresentDate.year!
        let hour = dateComponentForPresentDate.hour!
        let minute = dateComponentForPresentDate.minute!
        let timeInString = String(day)+"/"+String(month)+"/"+String(year)+"  "+String(hour)+":"+String(minute)
        print("*****",timeInString)
        return timeInString
    }
}
