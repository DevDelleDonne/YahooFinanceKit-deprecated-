//
//  File.swift
//  
//
//  Created by Alberto Delle Donne on 18/09/22.
//

import Foundation

public struct SearchTickersResponse: Decodable {
    public let data: [Ticker]?
    public let error: ErrorResponse?
    
    enum CodingKeys: CodingKey {
        case quotes
        case finance
    }
    
    enum FinanceKeys: CodingKey {
        case error
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decodeIfPresent([Ticker].self, forKey: .quotes)
        error = try? container.nestedContainer(keyedBy: FinanceKeys.self, forKey: .finance).decodeIfPresent(ErrorResponse.self, forKey: .error)
    }
}

public struct Ticker: Codable, Identifiable, Hashable, Equatable {
    
    public let id = UUID()
    
    public let symbol: String
    public let quoteType: String?
    public let shortName: String?
    public let longName: String?
    public let sector: String?
    public let industry: String?
    public let exchDisp: String?
    
    public init(symbol: String, quoteType: String?, shortName: String?, longName: String?, sector: String?, industry: String?, exchDisp: String?) {
        self.symbol = symbol
        self.quoteType = quoteType
        self.shortName = shortName
        self.longName = longName
        self.sector = sector
        self.industry = industry
        self.exchDisp = exchDisp
    }
}
