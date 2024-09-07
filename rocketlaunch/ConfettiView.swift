import SwiftUI

// A view that controls whether confetti animation should be displayed.
struct ConfettiView: View {
    @Binding var isAnimating: Bool // Binding to control animation state externally.
    
    var body: some View {
        ZStack {
            if isAnimating {
                ConfettiParticles() // The actual confetti particles view.
                    .edgesIgnoringSafeArea(.all) // Allows the confetti to cover the entire screen.
            }
        }
    }
}

// View responsible for generating and animating confetti particles.
private struct ConfettiParticles: View {
    @State private var particles: [ConfettiParticle] = [] // State to track individual particles.
    
    var body: some View {
        ZStack {
            // Renders each particle as a ConfettiShape with specific properties.
            ForEach(particles) { particle in
                ConfettiShape(color: particle.color) // The confetti piece's shape and color.
                    .offset(particle.offset) // Position offset for the particle.
                    .rotationEffect(Angle(degrees: particle.rotation)) // Rotation of the particle.
            }
        }
        .onAppear {
            startAnimating() // Initiates the confetti animation when the view appears.
        }
        .onDisappear {
            stopAnimating() // Cleans up by removing all particles when the view disappears.
        }
    }
    
    // Starts the confetti animation by periodically adding new particles.
    private func startAnimating() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            // Random properties for new particles.
            let xOffset = CGFloat.random(in: -300...300)
            let yOffset = CGFloat.random(in: -100...800)
            let rotation = Double.random(in: 0...360)
            let color = Color.random() // Custom extension to generate a random color.
            let particle = ConfettiParticle(offset: CGSize(width: xOffset, height: yOffset), rotation: rotation, color: color)
            particles.append(particle)
            
            // Removes the particle after a delay to prevent endless accumulation.
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let index = particles.firstIndex(of: particle) {
                    particles.remove(at: index)
                }
            }
        }
        timer.fire()
    }
    
    // Stops the confetti animation by clearing all particles.
    private func stopAnimating() {
        particles.removeAll()
    }
}

// Represents an individual confetti particle with unique properties.
private struct ConfettiParticle: Identifiable, Equatable {
    let id = UUID() // Unique identifier for SwiftUI's ForEach.
    let offset: CGSize // Position offset for animation.
    let rotation: Double // Rotation angle.
    let color: Color // Color of the particle.
}

// Defines the shape of a single piece of confetti.
private struct ConfettiShape: View {
    let color: Color // Color of the confetti shape.
    
    var body: some View {
        Path { path in
            // Draws a simple geometric shape for the confetti piece.
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 5, y: 10))
            path.addLine(to: CGPoint(x: 10, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
        .fill(color) // Fills the shape with the specified color.
    }
}

// Extension to generate a random color.
extension Color {
    static func random() -> Color {
        // Randomly generates red, green, and blue components.
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}
