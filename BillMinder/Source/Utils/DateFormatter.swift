//
//  DateFormatter.swift
//  BillMinder
//
//  Created by Gabriel dos Passos on 07/03/25.
//

import Foundation

public func dateFormatter(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    
    return dateFormatter.string(from: date)
}
