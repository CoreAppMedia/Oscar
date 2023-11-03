//
//  cargarImagen.swift
//  ProyectoChipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 02/11/23.
//

import SwiftUI

struct cargarImagen: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false

    
var body: some View {
        VStack {
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                Button("Guardar en Firebase") {
                    // Guardar la imagen en Firebase Storage
                    uploadImageToFirebase(selectedImage)
                }
            } else {
                Button("Seleccionar imagen") {
                    // Mostrar el selector de imágenes
                    isImagePickerPresented.toggle()
                }
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage)
        }
    }
    
    func uploadImageToFirebase(_ image: UIImage?) {
        // Sube la imagen a Firebase Storage aquí
        // Asegúrate de configurar Firebase Storage y autenticarte adecuadamente
    }
}

#Preview {
    cargarImagen()
}
