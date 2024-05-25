//
//  UserRepository.swift
//  NetworkTry
//
//  Created by Md. Masud Rana on 5/25/24.
//

import Foundation

class UserRepository: IRepository {
    func fetchUsers() async throws -> [User] {
        do {
            return try await NetworkManager().fetch(from: "https://gorest.co.in/public/v2/users", header: ["Authorization": "Bearer \(Env.bearToken)"])
        } catch {
            throw error
        }
    }

    func createUser(name: String, gender: String, email: String, status: String) async throws -> User {
        do {
            return try await NetworkManager().post(
                from: "https://gorest.co.in/public/v2/users",
                body: [
                    "name": name,
                    "gender": gender.lowercased(),
                    "email": email,
                    "status": status.lowercased()
                ],
                header: ["Authorization": "Bearer \(Env.bearToken)"]
            )
        } catch {
            throw error
        }
    }

    func updateUser(_ user: User) async throws -> User {
        do {
            return try await NetworkManager().put(
                from: "https://gorest.co.in/public/v2/users/\(user.id)",
                body: [
                    "name": user.name,
                    "email": user.email,
                    "status": user.status.lowercased()
                ],
                header: ["Authorization": "Bearer \(Env.bearToken)"]
            )
        } catch {
            throw error
        }
    }

    func deleteUser(_ id: Int) async throws {
        print("Come UserRepository..")
        do {
            print("before try UserRepository..")
            try await NetworkManager().delete(
                from: "https://gorest.co.in/public/v2/users/\(id)",
                header: ["Authorization": "Bearer \(Env.bearToken)"]
            )

            print("after try UserRepository..")
        } catch {
            print("error UserRepository..")
            throw error
        }
    }
}
