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
    @Published var isError: Bool = false
    @Published var isSuccess: Bool = false

    func fetchUsers() async {
        do {
            let user: [User] = try await NetworkManager().fetch(from: "https://gorest.co.in/public/v2/users", header: ["Authorization": "Bearer \(Env.bearToken)"])
            
            Task { @MainActor in
                self.users = user
            }
        } catch {
            print(error)
            self.isError = true
            self.errorMessage = error.localizedDescription
        }
    }
    
//    func getPosts() async {
//        do {
//            let posts: [PostModel] = try await NetworkManager().fetch(from: "https://gorest.co.in/public/v2/posts", header: ["Authorization": bearToken])
//
//            Task { @MainActor in
//                self.posts = posts
//            }
//        } catch {
//            print(error)
//            self.isError = true
//            self.errorMessage = error.localizedDescription
//        }
//    }
    
    func createUser(
        name: String,
        gender: String,
        mail: String,
        status: String
    ) async {
        do {
            let user: User = try await NetworkManager().post(
                from: "https://gorest.co.in/public/v2/users",
                body: [
                    "name": "\(name)",
                    "gender": "\(gender.lowercased())",
                    "email": "\(mail)",
                    "status": "\(status.lowercased())",
                ],
                header: ["Authorization": "Bearer \(Env.bearToken)"]
            )
            
            //  print("\(user)..from create")
            
            Task { @MainActor in
                self.users?.append(user)
            }
            
            self.isSuccess = true
            
        } catch {
            print(error)
            self.isError = true
            self.errorMessage = error.localizedDescription
        }
    }
    
    func updateUser(_ user: User) async {
        print("\(Env.bearToken)...")
        do {
            let updatedUser: User = try await NetworkManager().put(
                from: "https://gorest.co.in/public/v2/users/\(user.id)",
                body: [
                    "name": "\(user.name)",
                    "email": "\(user.email)",
                    "status": "\(user.status.lowercased())",
                ],
                header: ["Authorization": "Bearer \(Env.bearToken)"]
            )
            // print("\(updatedUser)..come after network call")
            
            Task { @MainActor in
                if let index = self.users?.firstIndex(where: { $0.id == user.id }) {
                    // print("Enter into task")
                    
                    self.users![index] = updatedUser
                }
            }
            
            self.isSuccess = true
            
        } catch {
            print(error)
            self.isError = true
            self.errorMessage = error.localizedDescription
        }
    }
    
    func deleteUser(_ id: Int) async {
        print("\(id)..id")
        print("\(self.users?.count ?? 0)..")
        guard id < (self.users?.count ?? 0) else { return }
        
        print("come after guard")
        let user = self.users![id]
        let userID = user.id
        
        do {
            try await NetworkManager().delete(
                from: "https://gorest.co.in/public/v2/users/\(userID)",
                header: ["Authorization": "Bearer \(Env.bearToken)"]
            )
           
            Task { @MainActor in
                self.users?.removeAll(where: { user in
                    print("\(user.name).. from remove")
                    return user.id == userID
                })
            }
            
            self.isSuccess = true
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
