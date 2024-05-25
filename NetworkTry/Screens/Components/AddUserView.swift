//
//  AddUserView.swift
//  NetworkTry
//
//  Created by Md. Masud Rana on 5/23/24.
//

import SwiftUI

struct AddUserView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var email = ""
    @State private var status = ""
    @State private var gender = ""
    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("User Details")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                    TextField("Status", text: $status)
                    TextField("Gender", text: $gender)
                }

                Button(action: {
                    Task {
                        await viewModel.createUser(name: name, gender: gender, mail: email, status: status)
                    }
                    
                    dismiss()
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
}

//#Preview {
//    AddUserView()
//}
