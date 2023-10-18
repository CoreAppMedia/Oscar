//
//  ViewPrincipal.swift
//  FireBase
//
//  Created by Oscar Valdes on 18/10/23.
//

import SwiftUI

struct ViewPrincipal: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ViewPrincipal(authenticationViewModel: AuthenticationViewModel())
}
