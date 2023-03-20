//
//  ContentView.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-03.
//

import SwiftUI

struct MainHomeView: View {
    var body: some View {
        ZStack {
            Color.customBackground.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 20) {
                    Spacer(minLength: 100)
                    NavigationLink(destination: IntervalTrainingView()) {
                        MenuButtonLabel(label: "Interval Training", icon: "play.fill")
                    }
                    .buttonStyle(.plain)
                    NavigationLink(destination: NoteRecognitionMainView()) {
                        MenuButtonLabel(label: "Note Recognition", icon: "music.note")
                    }
                    .buttonStyle(.plain)
                    NavigationLink(destination: ChordRecognitionMainView()) {
                        MenuButtonLabel(label: "Chord Recognition", icon: "music.quarternote.3")
                    }
                    .buttonStyle(.plain)
                    NavigationLink(destination: SettingsView()) {
                        MenuButtonLabel(label: "Settings", icon: "gearshape.fill")
                    }
                    .buttonStyle(.plain)
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Moûsa")
                            .font(.title)
                            .bold()
                            .foregroundStyle(AngularGradient.purpleGradient)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: EmptyView()) {
                            Image("leaderboard")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .accessibilityIdentifier("Statistics")
                                .foregroundStyle(.white)
                                .padding(12)
                                .background {
                                    Color.accentColor
                                }
                                .clipShape(Circle())
                                .frame(width: 44, height: 44)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainHomeView()
        }
    }
}

struct MenuButtonLabel: View {
    let label: String
    let icon: String
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.white)
                .frame(height: 80)
                .overlay {
                    HStack {
                        Image(systemName: icon)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .background(Color.accentColor)
                            .clipShape(Circle())
                        Spacer()
                        Text(label)
                            .font(.title3)
                            .bold()
                            .foregroundStyle(AngularGradient.purpleGradient)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.horizontal)
        }
    }
}
