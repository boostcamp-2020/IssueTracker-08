//
//  FormattedDateFromString.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/01.
//

import Foundation

func FormattedDateFromString(dueDate: String) -> String {
    let inputFormatter = DateFormatter()
    let outputFormatter = DateFormatter()
    var outputDate: String = ""
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    if let date = inputFormatter.date(from: dueDate) {
        outputFormatter.dateFormat = "yyyy년 MM월 dd일"
        outputDate = outputFormatter.string(from: date)
    }
    
    return outputDate
}

func FormattedEditDateString(dueDate: String) -> String {
    let inputFormatter = DateFormatter()
    let outputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy년 MM월 dd일까지"
    var outputDate: String = ""
    
    if let date = inputFormatter.date(from: dueDate) {
        outputFormatter.dateFormat = "yyyy-MM-dd"
        outputDate = outputFormatter.string(from: date)
    }
    
    return outputDate
}

func FormattedDifferenceDateString(dueDate: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let currentDate = Date()
    let date = inputFormatter.date(from: dueDate)
    let difference = currentDate.timeIntervalSince(date!)
    
    if difference > 62208000 {
        return "\(Int(difference / 62208000)) years ago"
    }
    else if difference > 2592000 {
        return "\(Int(difference / 2592000)) months ago"
    }
    else if difference > 86400 {
        return "\(Int(difference / 86400)) days ago"
    }
    else if difference > 3600 {
        return "\(Int(difference / 3600)) hours ago"
    }
    else if difference > 60 {
        return "\(Int(difference / 60)) minutes ago"
    }
    
    return "\(Int(difference)) seconds ago"
}
