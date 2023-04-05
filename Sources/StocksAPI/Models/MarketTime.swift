//
//  File.swift
//  
//
//  Created by Alberto Delle Donne on 05/04/23.
//

import Foundation

public struct TimeResponse: Decodable {
    
    public let data: [Time]?
    public let error: ErrorResponse?
    
    enum CodingKeys: CodingKey {
        case data
    }
    
    enum FinanceKeys: CodingKey {
        case result
        case error
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let timeContainer = try? container.nestedContainer(keyedBy: FinanceKeys.self, forKey: .data) {
            data = try? timeContainer.decodeIfPresent([Time].self, forKey: .result)
            error = try? timeContainer.decodeIfPresent(ErrorResponse.self, forKey: .error)
        } else {
            data = nil
            error = nil
        }
    }
    public init(data: [Time]?, error: ErrorResponse?) {
        self.data = data
        self.error = error
    }
}

public struct Time: Codable, Identifiable, Hashable, Equatable {
    
    public let id: String = UUID().uuidString
    
    public let name: String
    public let status: String?
    public let close: String?
    public let message: String?
    public let open: String?
    public let time: String?
    
    public init(name: String, status: String?, close: String?, message: String?, open: String?, time: String?) {
        self.name = name
        self.status = status
        self.close = close
        self.message = message
        self.open = open
        self.time = time
    }
}
