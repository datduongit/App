//
//  HomeData.swift
//  App
//
//  Created by ChungTV on 04/06/2021.
//

import Foundation

struct HomeData: Decodable {
    let displayType: String?
    let priority: Int?
    let englishLabel: String?
    let localLabel: String?
    let moreTargetUri: String?
    let englishDetailLabel: String?
    let localDetailLabel: String?
    let resourceType: String?
    let announcementIds: [Int]?
}
