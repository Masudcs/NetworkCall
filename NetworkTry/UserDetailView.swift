//
//  UserDetailView.swift
//  NetworkTry
//
//  Created by Md. Masud Rana on 5/23/24.
//

import SwiftUI

struct UserDetailView: View {
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
                 }
                 
                 Button(action: {
                     Task {
                         await viewModel.updateUser(user)
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
             .navigationTitle("Edit User")
    }
}

#Preview {
    UserDetailView(
        user: User(
            id: 1,
            name: "dskkdk",
            email: "dsjds@dkdk.com",
            message: "hello",
            field: "mail"
        ),
        viewModel: UserViewModel()
    )
}
