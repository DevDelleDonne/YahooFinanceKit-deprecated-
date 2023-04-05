//
//  File.swift
//  
//
//  Created by Alberto Delle Donne on 18/09/22.
//

import Foundation
import StocksAPI

@main
struct StocksAPIExec {
    
    static let stocksAPI = KISStocksAPI()
    
    static func main() async {
        do {
//            let quotes = try await stocksAPI.fetchQuotes(symbols: "APPL,MSFT,GOOG,TSLA")
//            print(quotes)
            
            let times = try await stocksAPI.fetchMarketTime(region: "IT")
            print(times)
//            let tickers = try await stocksAPI.searchTickers(query: "BTC-USD")
//            print(tickers)
//            if let chart = try await stocksAPI.fetchChartData(symbol: "AAPL", range: .oneDay) {
//                print(chart)
//            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
