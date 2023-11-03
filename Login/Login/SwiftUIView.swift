//
//  SwiftUIView.swift
//  Login
//
//  Created by mac20@ioslabacatlan.appleid.com on 02/11/23.
//

import SwiftUI
import Firebase

struct SwiftUIView: View {

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
    SwiftUIView()
}

/*
func uploadImageToFirebase(_ image: UIImage?) {
    guard let image = image else {
        // Asegurarse de que haya una imagen seleccionada
        return
    }

    // Crear una referencia al almacenamiento de Firebase
    let storage = Storage.storage()
    let storageRef = storage.reference()

    // Crear un nombre único para la imagen (puedes personalizar esto)
    let imageUUID = UUID().uuidString
    let imageName = "\(imageUUID).jpg"

    // Convertir la imagen a datos
    if let imageData = image.jpegData(compressionQuality: 0.8) {
        // Crear una referencia al archivo en Firebase Storage
        let imageRef = storageRef.child(imageName)

        // Subir la imagen
        let uploadTask = imageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error al subir la imagen a Firebase Storage: \(error.localizedDescription)")
            } else {
                // La imagen se ha subido correctamente, puedes realizar acciones adicionales aquí
                print("Imagen subida con éxito")
            }
        }

        // Puedes monitorear el progreso de la carga si lo deseas
        uploadTask.observe(.progress) { snapshot in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            print("Progreso de carga: \(percentComplete)%")
        }
    }
}
*/
