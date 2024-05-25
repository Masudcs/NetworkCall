//
//  Env.swift
//  NetworkTry
//
//  Created by Md. Masud Rana on 5/25/24.
//

import Foundation

struct Env {
    static let bearToken = Bundle.main.object(forInfoDictionaryKey: "CONF_Bearer_Token") as! String
}
