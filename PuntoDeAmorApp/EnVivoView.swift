//
//  EnVivoView.swift
//  PuntoDeAmorApp
//
//  Created by Ernesto Solis on 4/4/26.
//

import SwiftUI

struct EnVivoView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                // Tarjeta de Video (Placeholder)
                VStack(alignment: .leading, spacing: 15) {
                    ZStack {
                        // Simulamos una pantalla de video de 16:9
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.black.opacity(0.8))
                            .aspectRatio(16/9, contentMode: .fit)
                        
                        VStack(spacing: 10) {
                            Image(systemName: "dot.radiowaves.left.and.right")
                                .font(.system(size: 50))
                                .foregroundColor(.pink)
                            
                            Text("La transmisión no ha comenzado")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .shadow(radius: 10)
                    
                    Text("Nuestras transmisiones son todos los Domingos a las 9:00 AM y 11:00 AM.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 5)
                }
                .padding()

                // Botones de Redes Sociales
                VStack(spacing: 15) {
                    Button(action: {
                        if let url = URL(string: "https://www.youtube.com/@TuCanal") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Image(systemName: "play.tv.fill")
                            Text("Ver en YouTube Live")
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }

                    Button(action: {
                        if let url = URL(string: "https://www.facebook.com/TuPagina") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Image(systemName: "f.square.fill")
                            Text("Ver en Facebook Live")
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 24/255, green: 119/255, blue: 242/255))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("En Vivo")
        }
    }
}

// Para ver la vista previa en Xcode
#Preview {
    EnVivoView()
}
