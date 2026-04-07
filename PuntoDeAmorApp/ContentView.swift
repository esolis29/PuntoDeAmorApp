//
//  DetalleDiscipuladoView.swift
//  PuntoDeAmorApp
//
//  Created by Ernesto Solis on 4/4/26.
//

import SwiftUI
import LocalAuthentication

// --- 1. EL CEREBRO DE LA APP (SIN FIREBASE) ---
struct ContentView: View {
    @State private var estaLogueado: Bool = false

    var body: some View {
        Group {
            if estaLogueado {
                // Menú Principal (Pestañas)
                TabView {
                    // --- VISTA DE INICIO ---
                    NavigationStack {
                        InicioView()
                    }
                    .tabItem {
                        Label("Inicio", systemImage: "house.fill")
                    }
                    
                    EnVivoView()
                        .tabItem {
                            Label("En Vivo", systemImage: "livephoto")
                        }
                    
                    EventosView()
                        .tabItem {
                            Label("Eventos", systemImage: "calendar")
                        }
                }
                .accentColor(.pink)
                
            } else {
                // Pantalla de Login
                LoginView(estaLogueado: $estaLogueado)
            }
        }
    }
}

import SwiftUI
import LocalAuthentication // Necesario para el Face ID

struct LoginView: View {
    @Binding var estaLogueado: Bool
    @State private var telefono = ""
    
    var body: some View {
        // Envolvemos TODO en un solo VStack principal
        VStack(spacing: 30) {
            
            Spacer() // Empuja el contenido al centro
            
            // --- 1. LOGO Y BIENVENIDA ---
            VStack(spacing: 20) {
                Image("logo-iglesia-ico") // Asegúrate de que este nombre esté en Assets
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                Text("Bienvenido a Casa")
                    .font(.title2).bold()
                    .foregroundColor(.primary)
            }
            .padding(.bottom, 20)
            
            // --- 2. CAMPO DE TEXTO ---
            VStack(alignment: .leading, spacing: 8) {
                Text("Teléfono Móvil")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading, 5)
                
                TextField("Ingresa tu número", text: $telefono)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)
            
            // --- 3. BOTONES DE ACCESO ---
            VStack(spacing: 20) {
                // Botón Entrar
                Button(action: {
                    withAnimation { self.estaLogueado = true }
                }) {
                    Text("Entrar")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                // Botón Face ID
                Button(action: { autenticarConFaceID() }) {
                    Label("Entrar con Face ID", systemImage: "faceid")
                        .font(.subheadline)
                        .foregroundColor(.pink)
                }
            }
            .padding(.horizontal, 40)
            
            Spacer() // Empuja todo hacia arriba para que quede balanceado
        }
        .offset(y: -60) // <--- Cambia este número para subirlo más (negativo) o bajarlo (positivo)
    }
    
    // FUNCIÓN FACE ID
    func autenticarConFaceID() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Acceso seguro a Punto de Amor") { exito, _ in
                DispatchQueue.main.async {
                    if exito {
                        withAnimation {
                            self.estaLogueado = true
                        }
                    }
                }
            }
        }
    }
}

struct InicioView: View {
    // 1. Variable que controla la visibilidad de la hoja de oración
    @State private var mostrarOracion = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // --- 1. IMAGEN DE FONDO ---
                Image("foto-campus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                // --- 2. FILTRO OSCURO ---
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                // --- 3. CONTENIDO PRINCIPAL ---
                VStack(spacing: 25) {
                    
                    // --- GRUPO SUPERIOR CON LOGO ---
                    VStack(spacing: 20) {
                        // El Logo de la Iglesia
                        Image("logo-iglesia")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        
                        // Textos de Bienvenida
                        VStack(spacing: 5) {
                            Text("Punto de Amor")
                                .font(.system(size: 42, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text("¡Bienvenidos a Casa!")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                    .padding(.top, 60)
                    
                    // --- HORARIOS ---
                    VStack(spacing: 8) {
                        HStack {
                            Image(systemName: "clock.fill")
                            Text("Horarios de Servicio")
                                .font(.headline)
                        }
                        Text("Domingos 9:00 AM & 11:00 AM")
                            .font(.subheadline).bold()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(BlurView(style: .systemUltraThinMaterialDark))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding(.horizontal, 30)

                    // --- BOTÓN: PLANEAR UNA VISITA ---
                    NavigationLink(destination: PlanearVisitaView()) {
                        Text("Planear una Visita")
                            .font(.headline).bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 233/255, green: 30/255, blue: 99/255))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer() // Empuja el grupo inferior hacia abajo

                    // --- GRUPO INFERIOR (BOTONES SECUNDARIOS) ---
                    VStack(spacing: 15) {
                        
                        // BOTÓN: PODEMOS ORAR POR TI
                        Button(action: {
                            mostrarOracion = true
                        }) {
                            HStack {
                                Image(systemName: "hands.sparkles.fill")
                                Text("Podemos orar por ti")
                                    .bold()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.15))
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                            .cornerRadius(15)
                        }

                        // BOTÓN: VER DISCIPULADOS
                        NavigationLink(destination: DiscipuladosView()) {
                            HStack {
                                Image(systemName: "graduationcap.fill")
                                Text("Ver Discipulados")
                                    .bold()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            )
                            .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
                    
                } // Cierre del VStack de Contenido
            } // Cierre del ZStack
        } // Cierre del NavigationStack
        .sheet(isPresented: $mostrarOracion) {
            OracionView()
        }
    }
}

// --- VISTAS COMPLEMENTARIAS ---



struct EventosView: View {
    let eventos = ["Servicio Dominical", "Reunión de Jóvenes", "Estudio Bíblico"]
    var body: some View {
        List(eventos, id: \.self) { evento in
            Label(evento, systemImage: "calendar")
        }
        .navigationTitle("Eventos")
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView { UIVisualEffectView(effect: UIBlurEffect(style: style)) }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
