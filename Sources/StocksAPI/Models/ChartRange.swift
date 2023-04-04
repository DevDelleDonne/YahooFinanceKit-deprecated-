//
//  File.swift
//  
//
//  Created by Alberto Delle Donne on 19/09/22.
//

import Foundation

public enum ChartRange: String, CaseIterable {
    case oneDay = "Day"
    case oneWeek = "Week"
    case oneMonth = "Month"
    case ytd
    case oneYear = "Year"
    case max
    
    public var interval: String {
        switch self {
        case .oneDay: return "1m"
        case .oneWeek: return "5m"
        case .oneMonth: return "90m"
        case .ytd, .oneYear: return "1d"
        case .max: return "3mo"
        }
    }
}
