import SwiftUI

// Defines a view that explains rocket science concepts, utilizing various UI components.
struct RocketExplanationView: View {
    // State variable to manage the navigation to the content view.
    @State private var isShowingContentView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Sets the background color of the view to white.
                Color.white.edgesIgnoringSafeArea(.all)
                
                // ScrollView to enable scrolling through content if it exceeds the screen size.
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        // Sections of content, each represented as a private computed property.
                        titleSection
                        introductionCard
                        rocketComponentsSection
                        successFactorsAndEquations
                        
                        // Navigation link to transition to a detailed rocket design view.
                        NavigationLink(destination: RocketDesignView().navigationBarHidden(true), isActive: $isShowingContentView) {
                            Text("Launch Rocket Simulation")
                                .fontWeight(.semibold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                        .padding(.vertical, 20)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true) // Hides the navigation bar for this view.
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Uses stack navigation style for compatibility.
    }
    
    // MARK: - View Components
    
    // Title section of the view.
    private var titleSection: some View {
        Text("Understanding Rockets")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.vertical, 20)
            .foregroundColor(.blue)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
    }
    
    // Introduction card with a brief description of rockets.
    private var introductionCard: some View {
        CardView(title: "Introduction to Rockets") {
            Text("""
                 From sending satellites into space to exploring distant planets, rockets are like our modern-day magic carpets, defying gravity with a blend of science and ingenuity. They're the key to unlocking the mysteries of the universe and reaching places we've only dreamed of. Rockets work by blasting out fuel through their engines, creating a powerful force that pushes them forward at incredible speeds.
                """)
            .foregroundColor(.black)
        }
    }
    
    // Section displaying the major components of a rocket.
    private var rocketComponentsSection: some View {
        HStack {
            CardView(title: "Rocket Components") {
                ForEach(RocketPart.allCases, id: \.self) { part in
                    DetailView(part: part)
                }
            }
            .foregroundColor(.black)
            .cornerRadius(12)
            Spacer()
            VStack {
                Image("rocketmodel") // Ensure this matches your asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 400)
                    .padding()
                Text("Model by R.V Nanditta")
                    .foregroundColor(.black)
            }
        }
    }
    ///Provides the var that has the HStack for the success factors and rocket science equations
    private var successFactorsAndEquations: some View {
        HStack(alignment: .top, spacing: 20) {
            CardView(title: "Key Success Factors") {
                successFactorsText
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.black)
            
            CardView(title: "Rocket Science Equations") {
                rocketEquationsText
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.black)
        }
    }
    //Text for success factors
    private var successFactorsText: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Key Success Factors in Rocket Launches")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Successful rocket launches rely on meticulous planning and design, emphasizing key factors such as aerodynamics, propulsion efficiency, and structural integrity.")
                    .font(.body)
                
                Group {
                    Text("1. Aerodynamic Drag")
                        .font(.headline)
                    
                    Text("Aerodynamic drag is the resistance that a rocket encounters as it travels through the atmosphere. Minimizing drag is essential for optimizing velocity and efficiency during flight.")
                        .font(.body)
                    
                    Divider()
                    
                    Text("2. Thrust vs Mass")
                        .font(.headline)
                    
                    Text("Thrust represents the force generated by the rocket's engines, while mass refers to the total weight of the rocket. Achieving a favorable thrust-to-mass ratio is critical for enabling the rocket to attain higher velocities and overcome gravitational forces.")
                        .font(.body)
                    
                    Divider()
                    
                    Text("3. Navigation")
                        .font(.headline)
                    
                    Text("Precise navigation systems are indispensable for ensuring that rockets maintain their intended trajectories. Rockets employ a variety of navigational sensors, including gyroscopes, GPS, and accelerometers, to facilitate accurate course tracking and adjustment.")
                        .font(.body)
                }
            }
            .padding()
        }
    }
    //Text for rocket equations
    private var rocketEquationsText: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Newton's 2nd Law of Physics")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("F = MA")
                    .font(.title2)
                
                Text("where:")
                    .font(.headline)
                
                Text("F = force")
                Text("M = mass")
                Text("A = acceleration")
                
                Text("This law helps us understand how rockets work. The thrust produced by the rocket engine is proportional to the mass of the expelled fuel and the acceleration of that fuel. Researchers have used this law to design rocket engines and fuel tanks.")
                    .font(.body)
                
                Text("The Tsiolkovsky Rocket Equation")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("\(String(describing: RocketEquation.tsiolkovsky))")
                    .font(.title2)
                
                Text("This equation illustrates the relationship between a rocket's velocity, the exhaust velocity of propellants, and the mass ratio of the rocket. It helps scientists calculate a rocket's final velocity.")
                    .font(.body)
                
                Text("Together, these equations provide the foundation for rocket science, explaining crucial aspects of space exploration.")
                    .font(.body)
            }
            .padding()
        }
    }}

enum RocketEquation {
    static let tsiolkovsky = "Δv = ve * ln(m0 / mf)"
}



// Preview Provider
struct RocketExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        RocketExplanationView()
    }
}

