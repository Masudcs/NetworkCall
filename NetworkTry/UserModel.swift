//
//  UserModel.swift
//  NetworkTry
//
//  Created by Md. Masud Rana on 5/23/24.
//

import Foundation

struct User: Codable {
    // let value: String

    let id: Int
    var name, email: String
    var gender, status: String?
    let message: String?
    let field: String?
}
