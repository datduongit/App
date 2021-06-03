//
//  HttpRequestError.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

enum HttpRequestError: Int, Error {
    case urlNil
    case httpBodyNil
    case indexOutOfBounce
}
