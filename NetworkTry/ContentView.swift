//
//  ContentView.swift
//  NetworkTry
//
//  Created by Softzino on 22/5/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm: RandomJokesViewModel = RandomJokesViewModel()

    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.user ?? []) { item in
                    Text(item.name ?? "")
                        .background(.yellow)
                        .padding()
                }
//
//
//                ForEach(vm.posts ?? []) { item in
//                    Text(item.title ?? "")
//                        .background(.red)
//                        .padding()
//                }
                
                Button {
                    Task.detached {
                        await vm.createUser()
                    }
                } label: {
                    Text("Add user")
                }
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .onAppear(perform: {
                Task.detached {
                    await vm.getUser()
                  //  await vm.getPosts()
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
