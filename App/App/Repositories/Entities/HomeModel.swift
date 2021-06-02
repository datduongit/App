//
//  HomeModel.swift
//  App
//
//  Created by Edric D on 02/06/2021.
//

import Foundation

struct HomeModel: Decodable {
    let displayType: String
    let priority: Int
    let englishLabel: String?
    let localLabel: String?
    let moreTargetURI: String?
    let englishDetailLabel: String?
    let localDetailLabel: String?
    let resourceType: String?
    let announcementIDs: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case displayType = "display_type"
        case priority
        case englishLabel = "english_label"
        case localLabel = "local_label"
        case moreTargetURI = "more_target_uri"
        case englishDetailLabel = "english_detail_label"
        case localDetailLabel = "local_detail_label"
        case resourceType = "resource_type"
        case announcementIDs = "announcement_ids"
    }
}
