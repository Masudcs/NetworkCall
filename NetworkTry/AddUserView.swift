//
//  AddUserView.swift
//  NetworkTry
//
//  Created by Md. Masud Rana on 5/23/24.
//

import SwiftUI

struct AddUserView: View {
    @State private var name = ""
    @State private var email = ""
    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        Form {
            Section(header: Text("User Details")) {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
            }

            Button(action: {
                Task {
                    await viewModel.createUser(name: name, mail: email)
                }
            }) {
                Text("Add User")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Add User")
    }
}

//#Preview {
//    AddUserView()
//}
