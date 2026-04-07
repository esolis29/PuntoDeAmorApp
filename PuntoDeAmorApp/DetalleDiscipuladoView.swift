//
//  DetalleDiscipuladoView.swift
//  PuntoDeAmorApp
//
//  Created by Ernesto Solis on 4/4/26.
//

import SwiftUI

struct DetalleDiscipuladoView: View {
    let nivel: String
    let titulo: String
    
    // Lista de videos de ejemplo (Luego los cambiaremos por tus videos reales)
    let videos = [
        VideoClase(titulo: "Introducción", duracion: "10:20", idYoutube: "dQw4w9WgXcQ"),
        VideoClase(titulo: "Lección 1: La Fe", duracion: "15:45", idYoutube: "dQw4w9WgXcQ"),
        VideoClase(titulo: "Lección 2: La Oración", duracion: "12:30", idYoutube: "dQw4w9WgXcQ")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Cabecera estilo Netflix (Banner del video principal)
                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.8), .clear]), startPoint: .bottom, endPoint: .top))
                        .frame(height: 250)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("NIVEL \(nivel)")
                            .font(.caption).bold()
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.pink)
                            .cornerRadius(5)
                        
                        Text(titulo)
                            .font(.title).bold()
                    }
                    .foregroundColor(.white)
                    .padding()
                }
                .background(Color.gray.opacity(0.3)) // Aquí irá la miniatura principal
                
                Text("Videos de la serie")
                    .font(.headline)
                    .padding(.horizontal)
                
                // Galería de Videos (Lista vertical tipo capítulos)
                VStack(spacing: 15) {
                    ForEach(videos) { video in
                        NavigationLink(destination: VideoPlayerView(video: video)) {
                            HStack(spacing: 15) {
                                // Miniatura del video
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.black.opacity(0.1))
                                        .frame(width: 120, height: 70)
                                    
                                    Image(systemName: "play.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(video.titulo)
                                        .font(.subheadline).bold()
                                        .foregroundColor(.primary)
                                    Text(video.duracion)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Modelo de datos para los videos
struct VideoClase: Identifiable {
    let id = UUID()
    let titulo: String
    let duracion: String
    let idYoutube: String
}
