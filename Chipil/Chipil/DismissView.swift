//
//  DismissView.swift
//  ChipilUITests
//
//  Created by mac20@ioslabacatlan.appleid.com on 19/10/23.
//

import SwiftUI

struct DismissView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack{
            Spacer()
            Button("Cerrar") {
                dismiss()
            }
            .tint(.black)
            .padding(.trailing, 12)
        }
        .foregroundColor(.blue)
        .font(.title3)
    }
}

#Preview {
    DismissView()
}
