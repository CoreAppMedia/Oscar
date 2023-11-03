//
//  RegisterEmailView.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 20/10/23.
//

import SwiftUI
import FirebaseFirestore
struct RegisterEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var LinkViewModel: LinkViewModel
    
    @State var textFieldEmail: String = ""
    @State var textFieldPasseord: String = ""
    @State var repeatedPassword: String = ""
    @State private var showingAlert = false
    
    @State private var nombre = ""
    @State private var apellidoP = ""
    @State private var apellidoM = ""
    @State private var descripcion = ""
    @State private var titulo = ""
    @State private var numeroTel = ""
    @State private var fecha = Date()
        
    
    var body: some View {
        VStack{
            DismissView()
        ScrollView{ 
            HStack{
                Image("Chipil")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                Text("Chipil")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
            }
            HStack{
                VStack(alignment: .leading, spacing: 12, content: {
                    Text("Registro")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Porfavor Registrese para continuar")
                        .foregroundColor(Color.white.opacity(0.5))
                        .padding(.top,-12)
                })
                
                Spacer(minLength: 0)
            }
            .padding()

                HStack{
                    Image(systemName: "envelope.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextField("Email", text: $textFieldEmail)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(textFieldEmail == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                
                HStack{
                    Image(systemName: "person.circle")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextField("Nombre(s)", text: $nombre)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(nombre == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                
                        HStack{
                            Image(systemName: "person.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 35)
                            TextField("Apellido paterno", text: $apellidoP)
                                .autocapitalization(.none)
                        }
                        .padding()
                        .background(Color.white.opacity(apellidoP == "" ? 0 : 0.12))
                        .cornerRadius(15)
                        .padding(.horizontal)
                        HStack{
                            Image(systemName: "person")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 35)
                            TextField("Apellido Materno", text: $apellidoM)
                                .autocapitalization(.none)
                        }
                        .padding()
                        .background(Color.white.opacity(apellidoM == "" ? 0 : 0.12))
                        .cornerRadius(15)
                        .padding(.horizontal)
                HStack{
                    Image(systemName: "phone.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextField("Telefono", text: $numeroTel)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(numeroTel == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .keyboardType(.numberPad)
                HStack{
                    Image(systemName: "pencil.and.scribble")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextField("Descripcion", text: $descripcion)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(descripcion == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                HStack{
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextField("grupo al que pertenece", text: $titulo)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(titulo == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                    
                    DatePicker("Nacimiento: ", selection: $fecha, displayedComponents: .date)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(10)
                        .frame(width: UIScreen.main.bounds.width - 120)
                        .background(Color.white.opacity(0.6))
                        .clipShape(Capsule())
                    Divider()
                HStack{
                    Image(systemName: "lock")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    SecureField("Password", text: $textFieldPasseord)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(textFieldPasseord == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                HStack{
                    Image(systemName: "lock.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    SecureField("Repetir Password", text: $repeatedPassword)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(repeatedPassword == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)

                        .padding(.bottom)
                Button("Aceptar") {
                    if textFieldPasseord == repeatedPassword {
                        // Las contraseñas coinciden, continuar con la autenticación y el registro.
                        authenticationViewModel.createNewUser(email: textFieldEmail, password: textFieldPasseord)
                        LinkViewModel.crearTabla(nombre: nombre, apellidoP: apellidoP, apellidoM: apellidoM, descripcion: descripcion, titulo: titulo, numeroTel: numeroTel, textFieldEmail: textFieldEmail, fecha: fecha)
                    } else {
                        // Las contraseñas no coinciden, muestra un mensaje de error.
                        // Puedes manejar esto mostrando un mensaje de error al usuario.
                        showingAlert = true
                    }
                }
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 150)
                    .background(Color.green)
                    .clipShape(Capsule())
                    .opacity(textFieldEmail != "" && textFieldPasseord != "" && nombre != "" && apellidoP != "" && apellidoM != "" && titulo != "" && numeroTel != "" && descripcion != "" ? 1 : 0.5)
                    .disabled(textFieldEmail != "" && textFieldPasseord != "" && nombre != "" && apellidoP != "" && apellidoM != "" && titulo != "" && numeroTel != "" && descripcion != ""  ? false : true)
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Contraseñas no coinciden"),
                            message: Text("Las contraseñas ingresadas no coinciden. Por favor, asegúrate de que ambas contraseñas sean idénticas."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    if let messageError = authenticationViewModel.messageError{
                        Text("Error Master, ingresa un Usuario y contraeña valido")
                            .bold()
                            .font(.body)
                            .foregroundColor(.red)
                            .padding(.top,20)
                    }
                Spacer()
                
            }//ScrollView
        }//VStack principal
        .background(Color("chipil").ignoresSafeArea(.all, edges: .all))
    }
}

#Preview {
    RegisterEmailView(authenticationViewModel: AuthenticationViewModel(), LinkViewModel: LinkViewModel())
}
