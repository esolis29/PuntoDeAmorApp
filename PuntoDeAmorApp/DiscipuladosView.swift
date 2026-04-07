//
//  DiscipuladosView.swift
//  PuntoDeAmorApp
//
//  Created by Ernesto Solis on 4/4/26.
//

import SwiftUI

struct DiscipuladosView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Encabezado
                Text("Ruta de Crecimiento")
                    .font(.largeTitle).bold()
                    .padding(.horizontal)
                
                Text("Formando discípulos para el reino de Dios.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                // LISTA DE DISCIPULADOS (Tarjetas alineadas correctamente)
                VStack(spacing: 16) { // Spacing añade espacio uniforme entre tarjetas
                    
                    // NIVEL 1
                    NavigationLink(destination: DetalleDiscipuladoView(nivel: "1", titulo: "Primeros Pasos")) {
                        TarjetaDiscipulado(
                            numero: "1",
                            titulo: "Primeros Pasos",
                            descripcion: "Fundamentos básicos de la fe cristiana y conocimiento de la palabra.",
                            color: .blue
                        )
                    }

                    // NIVEL 2
                    NavigationLink(destination: DetalleDiscipuladoView(nivel: "2", titulo: "Vida en Victoria")) {
                        TarjetaDiscipulado(
                            numero: "2",
                            titulo: "Vida en Victoria",
                            descripcion: "Sanidad interior y libertad en Cristo para caminar en propósito.",
                            color: .orange // Cambié a orange para variar, puedes dejarlo blue
                        )
                    }

                    // NIVEL 3
                    NavigationLink(destination: DetalleDiscipuladoView(nivel: "3", titulo: "Liderazgo Eficaz")) {
                        TarjetaDiscipulado(
                            numero: "3",
                            titulo: "Liderazgo Eficaz",
                            descripcion: "Capacitación para servir en los diferentes ministerios de la iglesia.",
                            color: .purple // Cambié a purple para variar
                        )
                    }
                }
                .padding(.horizontal) // Esto ahora afecta a los TRES botones por igual

                // Botón de Información
                Button(action: contactarDirector) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                        Text("Solicitar inscripción o fechas")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink.opacity(0.1))
                    .foregroundColor(.pink)
                    .cornerRadius(12)
                }
                .padding()
            }
            .padding(.top)
        }
        .navigationTitle("Discipulados")
        .navigationBarTitleDisplayMode(.inline)
    }

    func contactarDirector() {
        let mensaje = "¡Hola! Me gustaría recibir información sobre los próximos inicios de discipulado."
        let mensajeCodificado = mensaje.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let telefono = "18131234567" // Tu número
        let url = URL(string: "https://wa.me/\(telefono)?text=\(mensajeCodificado)")!
        UIApplication.shared.open(url)
    }
}

// Componente visual para cada tarjeta de discipulado
struct TarjetaDiscipulado: View {
    var numero: String
    var titulo: String
    var descripcion: String
    var color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            // Círculo con el número del nivel
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 50, height: 50)
                Text(numero)
                    .font(.title2).bold()
                    .foregroundColor(color)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(titulo)
                    .font(.headline)
                Text(descripcion)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
