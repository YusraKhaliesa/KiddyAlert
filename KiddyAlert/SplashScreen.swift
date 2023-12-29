//
//  SplashScreen.swift
//  KiddyAlert
//
//  Created by user on 11/12/2023.
//
import SwiftUI
import AVFoundation

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var audioPlayer: AVAudioPlayer?

    var body: some View {
        if isActive {
            LoginView()
        } else {
            SplashContentView(size: $size, opacity: $opacity, isActive: $isActive)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.isActive = true
                    }
                }
        }
    }
}

struct SplashContentView: View {
    @Binding var size: Double
    @Binding var opacity: Double
    @Binding var isActive: Bool

    var body: some View {
        VStack {
            VStack {
                Text("Welcome To")
                    .foregroundStyle(Color.color)
                    .bold()
                Text("Kiddy Alert")
                    .font(.largeTitle)
                    .bold()
                    .overlay {
                            LinearGradient(
                                colors: [.red, .blue, .green, .yellow],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .mask(
                                Text("Kiddy Alert")
                                    .font(.largeTitle)
                                    .bold()
                                    )
                        }
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 2.0)) {
                    self.size = 2.0
                    self.opacity = 1.0
                }
                playSound()
            }
        }
    }

    func playSound() {
        guard let soundURL = Bundle.main.url(forResource: "level", withExtension: "mp3") else {
            return
        }

        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            print("done")
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}


// Add a Preview
struct SplashScreen_Preview: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
