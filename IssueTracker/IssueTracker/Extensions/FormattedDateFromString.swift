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
    if outputDate.isEmpty { return "" }
    return outputDate + "까지"
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
