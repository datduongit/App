//
//  EmptyResponse.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

public struct EmptyResponse: Codable {

}

public struct BoolResponse: Decodable {
    public let success: Bool?
}
