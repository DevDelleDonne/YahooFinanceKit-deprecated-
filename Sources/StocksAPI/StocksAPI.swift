import Foundation

public protocol IStocksAPI {
    func fetchChartData(tickerSymbol: String, range: ChartRange) async throws -> ChartData?
    func fetchChartRawData(symbol: String, range: ChartRange) async throws -> (Data, URLResponse)
    func searchTickers(query: String, isEquityTypeOnly: Bool) async throws -> [Ticker]
    func searchTickersRawData(query: String, isEquityTypeOnly: Bool) async throws -> (Data, URLResponse)
    func fetchQuotes(symbols: String) async throws -> [Quote]
    func fetchQuotesRawData(symbols: String) async throws -> (Data, URLResponse)
}

public struct KISStocksAPI: IStocksAPI {
    private let session = URLSession.shared
        private let jsonDecoder = {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            return decoder
        }()
        
        public init() {}
        
        private let baseURL = "https://query1.finance.yahoo.com"
        public func fetchChartData(tickerSymbol: String, range: ChartRange) async throws -> ChartData? {
            guard let url = urlForChartData(symbol: tickerSymbol, range: range) else { throw APIError.invalidURL }
            let (resp, statusCode): (ChartResponse, Int) = try await fetch(url: url)
            if let error = resp.error {
                throw APIError.httpStatusCodeFailed(statusCode: statusCode, error: error)
            }
            return resp.data?.first
        }
        
        public func fetchChartRawData(symbol: String, range: ChartRange) async throws -> (Data, URLResponse) {
            guard let url = urlForChartData(symbol: symbol, range: range) else { throw APIError.invalidURL }
            return try await session.data(from: url)
        }
        
        private func urlForChartData(symbol: String, range: ChartRange) -> URL? {
            guard var urlComp = URLComponents(string: "\(baseURL)/v8/finance/chart/\(symbol)") else {
                return nil
            }
            
            urlComp.queryItems = [
                URLQueryItem(name: "range", value: range.rawValue),
                URLQueryItem(name: "interval", value: range.interval),
                URLQueryItem(name: "indicators", value: "quote"),
                URLQueryItem(name: "includeTimestamps", value: "true")
            ]
            return urlComp.url
        }
        
        public func searchTickers(query: String, isEquityTypeOnly: Bool = true) async throws -> [Ticker] {
            guard let url = urlForSearchTickers(query: query) else { throw APIError.invalidURL }
            let (resp, statusCode): (SearchTickersResponse, Int) = try await fetch(url: url)
            if let error = resp.error {
                throw APIError.httpStatusCodeFailed(statusCode: statusCode, error: error)
            }
            let data = resp.data ?? []
            
                return data
            
        }
        
        public func searchTickersRawData(query: String, isEquityTypeOnly: Bool) async throws -> (Data, URLResponse) {
            guard let url = urlForSearchTickers(query: query) else { throw APIError.invalidURL }
            return try await session.data(from: url)
        }
        
        private func urlForSearchTickers(query: String) -> URL? {
            guard var urlComp = URLComponents(string: "\(baseURL)/v1/finance/search") else {
                return nil
            }
            
            urlComp.queryItems = [
                URLQueryItem(name: "lang", value: "en-US"),
                URLQueryItem(name: "quotesCount", value: "20"),
                URLQueryItem(name: "q", value: query)
            ]
            return urlComp.url
        }
    
    public func fetchMarketTime(region: String) async throws -> [Time] {
        guard let url = urlForMarketTime(region: region) else { throw APIError.invalidURL }
        let (resp, statusCode): (TimeResponse, Int) = try await fetch(url: url)
        if let error = resp.error {
            throw APIError.httpStatusCodeFailed(statusCode: statusCode, error: error)
        }
        return resp.data ?? []
        
        let postsTask = URLSession.shared.dataTask(with: postsURL) { data, response, error in
                    guard let data = data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let posts = try decoder.decode([Post].self, from: data)
                        DispatchQueue.main.async {
                            self.posts = posts
                        }
                    } catch let error {
                        print(error)
                    }
                }
                postsTask.resume()
    }
        
        public func fetchQuotes(symbols: String) async throws -> [Quote] {
            guard let url = urlForFetchQuotes(symbols: symbols) else { throw APIError.invalidURL }
            let (resp, statusCode): (QuoteResponse, Int) = try await fetch(url: url)
            if let error = resp.error {
                throw APIError.httpStatusCodeFailed(statusCode: statusCode, error: error)
            }
            return resp.data ?? []
        }
        
        public func fetchQuotesRawData(symbols: String) async throws -> (Data, URLResponse) {
            guard let url = urlForFetchQuotes(symbols: symbols) else { throw APIError.invalidURL }
            return try await session.data(from: url)
        }
    
        private func urlForMarketTime(region: String) -> URL? {
            guard var urlComp = URLComponents(string: "https://it.finance.yahoo.com/_finance_doubledown/api/resource/finance.market-time") else {
                return nil
            }
            urlComp.queryItems = [
                URLQueryItem(name: "returnMeta", value: "true"),
                URLQueryItem(name: "region", value: region)
                
            ]
            return urlComp.url
        }
        
        private func urlForFetchQuotes(symbols: String) -> URL? {
            guard var urlComp = URLComponents(string: "\(baseURL)/v7/finance/quote") else {
                return nil
            }
            urlComp.queryItems = [ URLQueryItem(name: "symbols", value: symbols) ]
            return urlComp.url
        }
        
        private func fetch<D: Decodable>(url: URL) async throws -> (D, Int) {
            let (data, response) = try await session.data(from: url)
            let statusCode = try validateHTTPResponse(response: response)
            return (try jsonDecoder.decode(D.self, from: data), statusCode)
        }
        
        private func validateHTTPResponse(response: URLResponse) throws -> Int {
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponseType
            }
            
            guard 200...299 ~= httpResponse.statusCode ||
                  400...499 ~= httpResponse.statusCode
            else {
                throw APIError.httpStatusCodeFailed(statusCode: httpResponse.statusCode, error: nil)
            }
            
            return httpResponse.statusCode
        }
}
