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
            ZStack {
                switch viewModel.state {
                case .loading:
                    ProgressView()

                case .failure(let error):
                    VStack {
                        Text("\(error)")
                            .padding()

                        Button {
                            Task {
                                await viewModel.retry()
                            }
                        } label: {
                            Text("Retry")
                        }
                    }
                    .padding()

                case .success:
                    List {
                        ForEach(viewModel.users ?? [], id: \.id) { user in
                            NavigationLink(destination: UserDetailView(user: user, viewModel: viewModel)) {
                                VStack(alignment: .leading) {
                                    Text(user.name)
                                    Text("UserID: \(user.id)")
                                        .font(.callout)
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
