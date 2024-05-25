//
//  IRepository.swift
//  NetworkTry
//
//  Created by Md. Masud Rana on 5/25/24.
//

import Foundation

protocol IRepository {
    func fetchUsers() async throws -> [User]
    func createUser(name: String, gender: String, email: String, status: String) async throws -> User
    func updateUser(_ user: User) async throws -> User
    func deleteUser(_ id: Int) async throws
}
