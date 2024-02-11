//
//  ContentView.swift
//  pruebaApi_php
//
//  Created by Oscar Valdes on 05/01/24.
//          


import SwiftUI

struct Contact: Codable {
    let idContacto: String
    let nombreContacto: String
    let telefono: String
    let correo: String
}

class ContactViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    
    init() {
        guard let url = URL(string: "http://192.168.7.7/pruebas_web/consulta.php") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let contacts = try JSONDecoder().decode([Contact].self, from: data)
                DispatchQueue.main.async {
                    self.contacts = contacts
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

struct ContactListView: View {
    @ObservedObject var viewModel = ContactViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.contacts, id: \.idContacto) { contact in
                VStack(alignment: .leading) {
                    Text("Nombre: \(contact.nombreContacto)")
                    Text("Teléfono: \(contact.telefono)")
                    Text("Correo: \(contact.correo)")
                }
            }
            .navigationBarTitle("Contactos Master")
        }
    }
}

struct ContentView: View {
    var body: some View {
        ContactListView()
    }
}



#Preview {
    ContentView()
}

