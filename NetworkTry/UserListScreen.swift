//
//  ContentView.swift
//  NetworkTry
//
//  Created by Softzino on 22/5/24.
//

import SwiftUI

struct UserListScreen: View {
    @StateObject private var viewModel: UserViewModel = UserViewModel()

    var body: some View {
        NavigationView {
                    List {
                        ForEach(viewModel.users ?? [], id: \.id) { user in
                            NavigationLink(destination: UserDetailView(user: user, viewModel: viewModel)) {
                                Text(user.name)
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let user = viewModel.users![index]
                                Task {
                                    await viewModel.deleteUser(user)
                                }
                            }
                        }
                    }
                    .navigationTitle("Users")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink("Add User") {
                                AddUserView(viewModel: viewModel)
                            }
                        }
                    }
                    .onAppear {
                        Task {
                            await viewModel.fetchUsers()
                        }
                    }
//                    .alert(item: $viewModel.errorMessage) { errorMessage in
//                        Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
//                    }
                }
    }
}

#Preview {
    UserListScreen()
}
