//
//  HomeView.swift
//  Chipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 19/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
  //  @StateObject var linkViewModel: LinkViewModel = LinkViewModel()
    var body: some View {
        
        NavigationView{
            VStack{
                BaseView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Logout"){
                    authenticationViewModel.logout()
                }
                .tint(.black)
            }
        }
    }
}

#Preview {
    HomeView(authenticationViewModel: AuthenticationViewModel())
}
