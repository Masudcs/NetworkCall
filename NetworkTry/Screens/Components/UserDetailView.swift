//
//  UserDetailView.swift
//  NetworkTry
//
//  Created by Md. Masud Rana on 5/23/24.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var user: User
    @ObservedObject var viewModel: UserViewModel

    init(user: User, viewModel: UserViewModel) {
        self._user = State(initialValue: user)
        self.viewModel = viewModel
    }

    var body: some View {
        Form {
            Section(header: Text("User Details")) {
                TextField("Name", text: $user.name)
                TextField("Email", text: $user.email)
                TextField("Status", text: $user.status)
            }

            Button(action: {
                Task {
                    await viewModel.updateUser(user)
                    await viewModel.fetchUsers()
                }
            }) {
                Text("Update User")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .alert(isPresented: $viewModel.isSuccess,
               content: {
                   Alert(
                       title: Text("Success"),
                       message: Text("Successfully update user")
                   )
               })
        .navigationTitle("Edit User")
    }
}

#Preview {
    UserDetailView(
        user: User(
            id: 1,
            name: "dskkdk",
            email: "dsjds@dkdk.com",
            status: "Active",
            message: "hello",
            field: "mail"
        ),
        viewModel: UserViewModel()
    )
}
