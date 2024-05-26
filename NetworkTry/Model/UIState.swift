//
//  UIState.swift
//  NetworkTry
//
//  Created by Md. Masud Rana on 5/26/24.
//

import Foundation

enum UIState : Equatable{
    case loading
    case success
    case failure(error: String)
}
