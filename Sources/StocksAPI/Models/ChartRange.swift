//
//  File.swift
//  
//
//  Created by Alberto Delle Donne on 19/09/22.
//

import Foundation

public enum ChartRange: String, CaseIterable {
    case oneDay = "1d"
    case oneWeek = "5d"
    case oneMonth = "1mo"
    case threeMonth = "3mo"
    case ytd
    case oneYear = "1y"
    case fiveYear = "5y"
    case max
    
    public var interval: String {
        switch self {
        case .oneDay: return "1m"
        case .oneWeek: return "5m"
        case .oneMonth: return "90m"
        case .threeMonth, .ytd, .oneYear: return "1d"
        case .fiveYear: return "1wk"
        case .max: return "3mo"
        }
    }
}
