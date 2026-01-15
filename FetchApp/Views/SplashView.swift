import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var fadeIn = false
    @State private var scale = 0.8

    var body: some View {
        if isActive {
            HomeView()
        } else {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Image(systemName: "book.fill") // replace with your logo asset
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundStyle(.orange)
                        .scaleEffect(scale)
                        .opacity(fadeIn ? 1 : 0)

                    Text("RecipeApp")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .opacity(fadeIn ? 1 : 0)

                    Text("Discover. Cook. Enjoy.")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .opacity(fadeIn ? 1 : 0)
                }
            }
            .onAppear {
                withAnimation(.easeIn(duration: 0.3)) {
                    fadeIn = true
                    scale = 1.0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
