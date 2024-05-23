//
//  JokeModel.swift
//  NetworkTry
//
//  Created by Softzino on 22/5/24.
//

import Foundation

struct UserModel: Codable, Identifiable {
    // let value: String

    let id: Int?
    let name, email, gender, status: String?
    let message: String?
    let field: String?
}

struct PostModel: Codable, Identifiable {
    let id, userID: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title, body
    }
}
