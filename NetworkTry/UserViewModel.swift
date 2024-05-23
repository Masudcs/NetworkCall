//
//  RandomJokesViewModel.swift
//  NetworkTry
//
//  Created by Softzino on 22/5/24.
//

import Foundation
import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [User]? = []
    @Published var posts: [PostModel]? = []
    @Published var errorMessage: String = ""

    func fetchUsers() async {
        do {
            let user: [User] = try await NetworkManager().fetch(from: "https://gorest.co.in/public/v2/users", header: ["Authorization": bearToken])
            self.users = user
        } catch {
            print(error)
        }
    }
    
    func getPosts() async {
        do {
            let posts: [PostModel] = try await NetworkManager().fetch(from: "https://gorest.co.in/public/v2/posts", header: ["Authorization": bearToken])
            DispatchQueue.main.async {
                self.posts = posts
            }
        } catch {
            print(error)
            self.errorMessage = error.localizedDescription
        }
    }
    
    func createUser(
        name: String = "Saifullah12r5",
        gender: String = "Male",
        mail: String = "hello1125361@gdsdd.com",
        status: String = "active"
    ) async {
        do {
            let users: User = try await NetworkManager().post(
                from: "https://gorest.co.in/public/v2/users",
                body: [
                    "name": "\(name)",
                    "gender": "\(gender)",
                    "email": "\(mail)",
                    "status": "\(status)",
                ],
                header: ["Authorization": "Bearer \(bearToken)"]
            )
            
            self.users?.append(users)
            
        } catch {
            print(error)
            self.errorMessage = error.localizedDescription
        }
    }
    
    func updateUser(_ user: User) async {
        do {
            let updatedUser: User = try await NetworkManager().put(
                from: "https://gorest.co.in/public/v2/users/\(user.id)",
                body: [
                    "name": "\(user.name)",
                    "email": "\(user.email)",
                ],
                header: ["Authorization": "Bearer \(bearToken)"]
            )
            DispatchQueue.main.async {
                if let index = self.users?.firstIndex(where: { $0.id == user.id }) {
                    self.users![index] = updatedUser
                }
            }
            
        } catch {
            print(error)
            self.errorMessage = error.localizedDescription
        }
    }
    
    func deleteUser(_ user: User) async {
        do {
            try await NetworkManager().delete(
                from: "https://api.example.com/users/\(user.id)",
                header: ["Authorization": "Bearer \(bearToken)"]
            )
            DispatchQueue.main.async {
                self.users?.removeAll { $0.id == user.id }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
