//
//  scheduler.swift
//  TabsView
//
//  Created by Derrick on 2021/03/04.
//


import Foundation

class scheduler
{
    
    var sno: Int = 0
    
    var startTime: String = ""
    
    var endTime: String = ""
    
    var title: String = ""
  
    var content: String = ""

    var date: String = ""

    
    init(sno:Int, startTime:String, endTime:String, title:String, content:String, date:String)
    {
        self.sno = sno
        self.startTime = startTime
        self.endTime = endTime
        self.title = title
        self.content = content
        self.date = date

    }
    
}
