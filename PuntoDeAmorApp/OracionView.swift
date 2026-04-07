//
//  OracionView.swift
//  PuntoDeAmorApp
//
//  Created by Ernesto Solis on 4/4/26.
//

import SwiftUI

struct OracionView: View {
    @Environment(\.dismiss) var dismiss
    
    // Variables para guardar lo que el usuario escribe
    @State private var nombre: String = ""
    @State private var peticion: String = ""
    @State private var esUrgente: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                // SECCIÓN 1: DATOS
                Section(header: Text("Tus Datos")) {
                    TextField("Tu Nombre", text: $nombre)
                        .autocorrectionDisabled()
                }
                
                // SECCIÓN 2: PETICIÓN
                Section(header: Text("¿Cómo podemos orar por ti?")) {
                    TextEditor(text: $peticion)
                        .frame(height: 150) // Espacio para escribir largo
                        .overlay(
                            Group {
                                if peticion.isEmpty {
                                    Text("Escribe tu motivo de oración aquí...")
                                        .foregroundColor(.gray.opacity(0.5))
                                        .padding(.leading, 5)
                                        .padding(.top, 8)
                                }
                            }, alignment: .topLeading
                        )
                }
                
                // SECCIÓN 3: PRIORIDAD
                Section {
                    Toggle("¿Es una petición urgente?", isOn: $esUrgente)
                        .tint(.pink)
                }
                
                // SECCIÓN 4: BOTÓN DE ENVÍO
                Section {
                    Button(action: enviarPeticionWhatsApp) {
                        HStack {
                            Spacer()
                            Image(systemName: "hands.sparkles.fill")
                            Text("Enviar Petición")
                                .bold()
                            Spacer()
                        }
                    }
                    .disabled(nombre.isEmpty || peticion.isEmpty) // No deja enviar si está vacío
                    .foregroundColor(.white)
                    .listRowBackground(nombre.isEmpty || peticion.isEmpty ? Color.gray : Color.green)
                }
            }
            .navigationTitle("Petición de Oración")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cerrar") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // FUNCIÓN PARA ENVIAR POR WHATSAPP
    func enviarPeticionWhatsApp() {
        let urgencia = esUrgente ? "🚨 *URGENTE*" : "🙏"
        let mensaje = """
        \(urgencia) *Nueva Petición de Oración*
        
        *Nombre:* \(nombre)
        *Petición:* \(peticion)
        """
        
        let mensajeCodificado = mensaje.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let telefono = "13524289488" // <--- PON TU NÚMERO AQUÍ
        
        let url = URL(string: "https://wa.me/\(telefono)?text=\(mensajeCodificado)")!
        UIApplication.shared.open(url)
    }
}
