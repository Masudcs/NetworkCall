//
//  RandomJokesViewModel.swift
//  NetworkTry
//
//  Created by Softzino on 22/5/24.
//

import Foundation
import SwiftUI

@MainActor
class RandomJokesViewModel: ObservableObject {
    @Published var user: [UserModel]? = []
    @Published var posts: [PostModel]? = []

    func getUser() async {
        do {
            let user: [UserModel] = try await NetworkManager().fetch(from: "https://gorest.co.in/public/v2/users", header: ["Authorization": bearToken])
            self.user = user
        } catch {
            print(error)
        }
    }
    
    func getPosts() async {
        do {
            let posts: [PostModel] = try await NetworkManager().fetch(from: "https://gorest.co.in/public/v2/posts", header: ["Authorization": bearToken])
            
            self.posts = posts
        } catch {
            print(error)
        }
    }
    
    func createUser(
        name: String = "Saifullah12",
        gender: String = "Male",
        mail: String = "hello11231@gdsdd.com",
//        mail: String = "\("ABCDEFGE".randomElement())\("1232443".randomElement())\("CMMkdsk".randomElement())\("ddjfdjyeu".randomElement())@gmail.com",
        status: String = "active"
    ) async {
        do {
            let users: UserModel = try await NetworkManager().post(
                from: "https://gorest.co.in/public/v2/users",
                body: [
                    "name": "\(name)",
                    "gender": "\(gender)",
                    "email": "\(mail)",
                    "status": "\(status)"
                ],
                header: ["Authorization": "Bearer \(bearToken)"]
            )
            self.user?.append(users)
            
        } catch {
            print(error)
        }
    }
}
