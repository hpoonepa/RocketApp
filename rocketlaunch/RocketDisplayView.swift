import SwiftUI

// Main view for displaying the rocket launch simulation, missing parts alert, or congratulations screen.
struct RocketDisplayView: View {
    // ViewModel to manage the state and data related to rocket parts.
    @ObservedObject var viewModel: RocketViewModel
    // State variables to control various UI elements and flow.
    @State private var isShowingRocketBuildingView = false // Determines if the rocket building view should be shown.
    @State private var countdown: Int? = nil // Optional countdown timer for launch sequence.
    @State private var showCongratulation = false // Controls the display of the congratulation message.
    @State private var rocketOffset: CGFloat = 0 // Controls the animation offset for the rocket launch.
    @State private var isConfettiAnimating: Bool = false // Controls the confetti animation for the congratulations view.
    @State private var showMissingPartsView: Bool = false // Determines if the missing parts alert should be shown.
    @State private var missingPartsDescription: String = "" // Description of missing parts, if any.
    
    var body: some View {
        ZStack {
            // Background gradient for the entire view.
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // Conditional views based on state variables.
            if showMissingPartsView {
                missingPartsView // View shown if there are missing rocket parts.
            } else if showCongratulation {
                congratulationsView // View shown when the rocket has been successfully launched.
            } else {
                rocketLaunchView // The main rocket launch view with countdown and launch button.
            }
        }
    }
    
    // View showing the rocket and launch button, including a countdown if initiated.
    private var rocketLaunchView: some View {
        VStack(spacing: 20) {
            RocketTrackersView(viewModel: viewModel, rocketOffset: $rocketOffset) // Custom view to display the rocket with tracking.
                .frame(width: 300, height: 300)
            Spacer()
            if let countdown = countdown {
                Text("\(countdown)")
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .scaleEffect(1.5)
                    .opacity(0.8)
                    .animation(.easeInOut(duration: 0.5), value: countdown)
            } else {
                launchButton // Button to initiate the rocket launch.
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // The launch button, checks if all parts are used before initiating countdown.
    private var launchButton: some View {
        Button(action: {
            if viewModel.allPartsUsed() {
                countdown = 3
                startCountdown() // Starts the countdown for the rocket launch.
            } else {
                missingPartsDescription = viewModel.missingPartsDescription() // Gets description of missing parts.
                showMissingPartsView = true // Shows the missing parts view.
            }
        }) {
            Text("Launch")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .shadow(radius: 5)
        }
        .scaleEffect(1.1)
    }
    
    // View displayed if there are missing rocket parts.
    private var missingPartsView: some View {
        VStack {
            Text("Missing Rocket Parts")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(missingPartsDescription)
                .foregroundColor(.red)
                .padding()
            
            Button("Rebuild Rocket") {
                isShowingRocketBuildingView = true
                viewModel.resetGame() // Resets the game to allow for a new rocket build.
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(radius: 5)
            .fullScreenCover(isPresented: $isShowingRocketBuildingView) {
                RocketDesignView() // Returns to the rocket design view for rebuilding.
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.8))
        .edgesIgnoringSafeArea(.all)
    }
    
    // View displayed upon successful rocket launch.
    private var congratulationsView: some View {
        ZStack {
            ConfettiView(isAnimating: $isConfettiAnimating) // Assumed custom confetti animation view.
            
            VStack {
                Text("Congratulations! Rocket Launched!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                    .padding()
                
                Button("Build Rocket Again") {
                    isConfettiAnimating = false // Stops the confetti animation.
                    isShowingRocketBuildingView = true
                    viewModel.resetGame() // Resets the game for a new build.
                    rocketOffset = 0 // Resets the rocket offset for the next launch.
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .shadow(radius: 5)
                .fullScreenCover(isPresented: $isShowingRocketBuildingView) {
                    RocketDesignView() // Returns to the rocket design view for a new build.
                }
            }
        }.onAppear {
            isConfettiAnimating = true // Starts the confetti animation upon view appearance.
        }
    }
    
    // Function to handle the countdown logic for the rocket launch.
    private func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if let countdown = self.countdown, countdown > 0 {
                self.countdown = countdown - 1 // Decrements the countdown each second.
            } else {
                timer.invalidate() // Stops the timer when countdown reaches 0.
                withAnimation(.easeInOut(duration: 2)) {
                    self.rocketOffset = -600 // Moves the rocket out of view to simulate launch.
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) { // Waits for the launch animation to complete.
                    self.showCongratulation = true // Shows the congratulations view.
                }
            }
        }
    }
}
