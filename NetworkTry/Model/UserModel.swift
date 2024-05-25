//
//  UserModel.swift
//  NetworkTry
//
//  Created by Md. Masud Rana on 5/23/24.
//

import Foundation

struct User: Codable {
    // let value: String

    var id: Int
    var name, email, status: String
    var gender: String?
    let message: String?
    let field: String?
}
