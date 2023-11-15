//
//  ContentView.swift
//  ChatGPT4
//
//  Created by Oscar Valdes on 15/11/23.
//

import SwiftUI

struct ContentView: View {
    var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Button{
                Task{
                    await viewModel.send()
                }
            }label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(Color.white)
                    .frame(width: 44,height: 44)
                    .background(Color.blue)
                    .cornerRadius(22)
                
            }
        }
        .padding(.leading,8)
    }
}

#Preview {
    ContentView()
}
