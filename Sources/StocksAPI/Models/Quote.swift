//
//  File.swift
//  
//
//  Created by Alberto Delle Donne on 18/09/22.
//

import Foundation

public struct QuoteResponse: Decodable {
    
    public let data: [Quote]?
    public let error: ErrorResponse?
    
    enum CodingKeys: CodingKey {
        case quoteResponse
        case finance
    }
    
    enum ResponseKeys: CodingKey {
        case result
        case error
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let quoteResponseContainer = try?container.nestedContainer(keyedBy: ResponseKeys.self, forKey: .quoteResponse) {
            self.data = try? quoteResponseContainer.decodeIfPresent([Quote].self, forKey: .result)
            self.error = try?
            quoteResponseContainer.decodeIfPresent(ErrorResponse.self, forKey: .error)
        } else if let financeResponseContainer = try? container.nestedContainer(keyedBy: ResponseKeys.self, forKey: .finance) {
            self.data = try? financeResponseContainer.decodeIfPresent([Quote].self, forKey: .result)
            self.error = try? financeResponseContainer.decodeIfPresent(ErrorResponse.self, forKey: .error)
        } else {
            self.data = nil
            self.error = nil
        }
    }
}

public struct Quote: Codable, Identifiable, Hashable, Equatable {
    
    public let id = UUID()
    
    public let symbol: String
    public let currency: String?
    public let marketState: String?
    public let fullExchangeName: String?
    public let displayName: String?
    public let regularMarketPrice: Double?
    public let regularMarketChange: Double?
    public let regularMarketChangePercent: Double?
    
    public let postMarketPrice: Double?
    public let postMarketPriceChange: Double?
    
    public let regularMarketOpen: Double?
    public let regularMarhetDayHigh: Double?
    public let regularMarketDayLow: Double?
    public let regularMarketPreviousClose: Double?
    
    public let regularMarketVolume: Double?
    public let trailingPE: Double?
    public let marketCap: Double?
    
    public let fiftyTwoWeekLow: Double?
    public let fiftyTwoWeekHigh: Double?
    public let averageDailyVolume3Month: Double?
    
    public let trailingAnnualDividentYeld: Double?
    public let epsTrailingTwelveMonths: Double?
    
    public init(symbol: String, currency: String? = nil, marketState: String? = nil, fullExchangeName: String? = nil, displayName: String? = nil, regularMarketPrice: Double? = nil, regularMarketChange: Double? = nil, regularMarketChangePercent: Double? = nil, postMarketPrice: Double? = nil, postMarketPriceChange: Double? = nil, regularMarketOpen: Double? = nil, regularMarhetDayHigh: Double? = nil, regularMarketDayLow: Double? = nil, regularMarketPreviousClose: Double? = nil, regularMarketVolume: Double? = nil, trailingPE: Double? = nil, marketCap: Double? = nil, fiftyTwoWeekLow: Double? = nil, fiftyTwoWeekHigh: Double? = nil, averageDailyVolume3Month: Double? = nil, trailingAnnualDividentYeld: Double? = nil, epsTrailingTwelveMonths: Double? = nil) {
        self.symbol = symbol
        self.currency = currency
        self.marketState = marketState
        self.fullExchangeName = fullExchangeName
        self.displayName = displayName
        self.regularMarketPrice = regularMarketPrice
        self.regularMarketChange = regularMarketChange
        self.regularMarketChangePercent = regularMarketChangePercent
        self.postMarketPrice = postMarketPrice
        self.postMarketPriceChange = postMarketPriceChange
        self.regularMarketOpen = regularMarketOpen
        self.regularMarhetDayHigh = regularMarhetDayHigh
        self.regularMarketDayLow = regularMarketDayLow
        self.regularMarketPreviousClose = regularMarketPreviousClose
        self.regularMarketVolume = regularMarketVolume
        self.trailingPE = trailingPE
        self.marketCap = marketCap
        self.fiftyTwoWeekLow = fiftyTwoWeekLow
        self.fiftyTwoWeekHigh = fiftyTwoWeekHigh
        self.averageDailyVolume3Month = averageDailyVolume3Month
        self.trailingAnnualDividentYeld = trailingAnnualDividentYeld
        self.epsTrailingTwelveMonths = epsTrailingTwelveMonths
    }
    
}
