//
//  File.swift
//  
//
//  Created by Alberto Delle Donne on 18/09/22.
//

import Foundation

public struct ErrorResponse: Codable {
    public let code: String
    public let description: String
    
    public init(code: String, description: String) {
        self.code = code
        self.description = description
    }
}
