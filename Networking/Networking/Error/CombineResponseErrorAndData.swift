//
//  CombineResponseErrorAndData.swift
//  Networking
//
//  Created by ChungTV on 03/06/2021.
//

import Foundation

struct CombineResponseErrorAndData: Error {
    var dataError: Data?
    var responseError: HttpResponseError?
}
