//
//  DismissView.swift
//  FireBase
//
//  Created by Oscar Valdes on 18/10/23.
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
        //.buttonStyle(.bordered)
    }
}

struct DismissView_Previews: PreviewProvider {
    static var previews: some View {
        DismissView()
    }
}

