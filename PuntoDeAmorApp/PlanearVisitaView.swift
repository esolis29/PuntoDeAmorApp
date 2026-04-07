//
//  PlanearVisitaView.swift
//  PuntoDeAmorApp
//
//  Created by Ernesto Solis on 4/4/26.
//

import SwiftUI

struct PlanearVisitaView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Cabecera Visual
                ZStack(alignment: .bottomLeading) {
                    Image("foto-campus") // Usamos la misma del inicio para consistencia
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                        .overlay(Color.black.opacity(0.3))
                    
                    Text("Te esperamos con los brazos abiertos")
                        .font(.title2).bold()
                        .foregroundColor(.white)
                        .padding()
                }
                .cornerRadius(15)
                .padding(.horizontal)

                // --- BOTÓN DE GPS (Añadir aquí) ---
                Button(action: abrirMapas) {
                    HStack {
                        Image(systemName: "map.fill")
                            .font(.headline)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Cómo llegar a la iglesia")
                                .font(.subheadline).bold()
                            Text("Abrir en Mapas / GPS")
                                .font(.caption2)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1)) // Un azul suave para diferenciarlo del rosa
                    .foregroundColor(.blue)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                    )
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                
                // Pasos para la visita (Tarjetas Estilo Opción B)
                VStack(alignment: .leading, spacing: 20) {
                    Text("¿Qué esperar?")
                        .font(.headline)
                        .padding(.horizontal)

                    TarjetaPaso(
                        icono: "car.fill",
                        titulo: "Estacionamiento",
                        descripcion: "Tenemos espacios reservados para visitantes justo al frente."
                    )
                    
                    TarjetaPaso(
                        icono: "face.smiling.fill",
                        titulo: "Anfitriones",
                        descripcion: "Al llegar, nuestro equipo de Punto de Amor te guiará al santuario."
                    )
                    
                    TarjetaPaso(
                        icono: "person.2.fill",
                        titulo: "Punto Kids",
                        descripcion: "Si vienes con niños, tenemos un área segura y divertida para ellos."
                    )
                }
                .padding(.horizontal)

                // 4. Botón de Confirmación (Estilo WhatsApp)
                Button(action: enviarAvisoVisita) {
                    HStack(spacing: 12) {
                        Image(systemName: "message.fill") // Ícono de burbuja de chat
                            .font(.headline)
                        
                        Text("Avisar por WhatsApp")
                            .font(.headline)
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    // El color hexadecimal oficial de WhatsApp es #25D366
                    .background(Color(red: 37/255, green: 211/255, blue: 102/255))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
                
                Spacer()
            }
        }
        .navigationTitle("Planear Visita")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Función para avisar al equipo
    func enviarAvisoVisita() {
        // 1. El mensaje que quieres recibir (puedes cambiarlo a tu gusto)
        let mensaje = "¡Hola! Planeo visitar Punto de Amor este próximo domingo. ¡Me gustaría que me contacten!"
        
        // 2. Tu número de teléfono (IMPORTANTE: Sin espacios, sin guiones y con código de país)
        // Ejemplo para USA: 1 + área + número -> 18130000000
        let telefono = "18134469328"
        
        // 3. Codificación del mensaje para que los espacios funcionen en internet
        let mensajeCodificado = mensaje.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        // 4. Creamos la URL final
        let urlWhatsApp = "https://wa.me/\(telefono)?text=\(mensajeCodificado)"
        
        if let url = URL(string: urlWhatsApp) {
            // 5. Ordenamos al sistema abrir el enlace
            UIApplication.shared.open(url)
        }
    }
    func abrirMapas() {
        // Reemplaza esta dirección por la ubicación exacta de Punto de Amor en Dade City
        let direccion = "14200 4th St, Dade City, FL 33523"
        let direccionCodificada = direccion.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        // Intentamos abrir Apple Maps primero
        let urlAppleMaps = "http://maps.apple.com/?address=\(direccionCodificada)"
        
        if let url = URL(string: urlAppleMaps) {
            UIApplication.shared.open(url)
        }
    }
}

// Componente pequeño para las tarjetas de pasos
struct TarjetaPaso: View {
    var icono: String
    var titulo: String
    var descripcion: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icono)
                .font(.title2)
                .foregroundColor(.pink)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(titulo).font(.subheadline).bold()
                Text(descripcion).font(.caption).foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
}
