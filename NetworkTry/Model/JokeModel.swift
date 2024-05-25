//
//  JokeModel.swift
//  NetworkTry
//
//  Created by Softzino on 22/5/24.
//

import Foundation



struct PostModel: Codable {
    let id, userID: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title, body
    }
}
