//
//  VideoPlayerView.swift
//  PuntoDeAmorApp
//
//  Created by Ernesto Solis on 4/4/26.
//

import SwiftUI

struct VideoPlayerView: View {
    let video: VideoClase
    @State private var mostrarQuiz = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Aquí iría el reproductor de YouTube
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.black)
                .aspectRatio(16/9, contentMode: .fit)
                .overlay(
                    Text("Reproductor de Video: \(video.titulo)")
                        .foregroundColor(.white)
                )
                .padding()
            
            Text("¡Felicidades por terminar la lección!")
                .font(.headline)
            
            // BOTÓN DEL QUIZ
            Button(action: { mostrarQuiz = true }) {
                HStack {
                    Image(systemName: "checkmark.seal.fill")
                    Text("Tomar el Pequeño Quiz")
                }
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle(video.titulo)
        .sheet(isPresented: $mostrarQuiz) {
            Text("Aquí diseñaremos tu Quiz pronto...") // Placeholder del Quiz
                .presentationDetents([.medium])
        }
    }
}
