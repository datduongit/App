//
//  HomeData.swift
//  App
//
//  Created by ChungTV on 04/06/2021.
//

import Foundation

struct HomeData: Decodable {
    var displayType: String?
    var priority: Int?
    var englishLabel: String?
    var localLabel: String?
    var moreTargetUri: String?
    var englishDetailLabel: String?
    var localDetailLabel: String?
    var resourceType: String?
    var announcementIds: [Int]?
}
