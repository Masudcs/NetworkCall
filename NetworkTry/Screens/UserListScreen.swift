//
//  ContentView.swift
//  NetworkTry
//
//  Created by Softzino on 22/5/24.
//

import SwiftUI

struct UserListScreen: View {
    @StateObject private var viewModel: UserViewModel = .init()
    @State private var showAddUser: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users ?? [], id: \.id) { user in
                    NavigationLink(destination: UserDetailView(user: user, viewModel: viewModel)) {
                        HStack {
                            Text(user.name)
                            Text("\(user.id)")
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        Task {
                            await viewModel.deleteUser(index)
                            await viewModel.fetchUsers()
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddUser = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchUsers()
                }
            }
            .alert(isPresented: $viewModel.isError) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .alert(isPresented: $viewModel.isSuccess) {
                Alert(
                    title: Text("Success"),
                    message: Text("User Successfully delete"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .sheet(isPresented: $showAddUser) {
                AddUserView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    UserListScreen()
}
