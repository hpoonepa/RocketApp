import SwiftUI
import UniformTypeIdentifiers

// View for designing a rocket, where users can select, place, and customize rocket parts.
struct RocketDesignView: View {
    // ViewModel to manage the state and logic of the rocket design process.
    @StateObject private var viewModel: RocketViewModel
    // State variable to control the visibility of a tutorial overlay.
    @State private var showingTutorial = true
    // State variable to navigate to the RocketDisplayView when the user decides to launch the rocket.
    @State private var isNavigateToRocketDisplayView = false
    
    // Initializes the view with predefined rocket parts and sets up the ViewModel.
    init() {
        // Define initial rocket parts with their properties (e.g., name, description, color options).
        let initialRocketParts: [RocketPartModel] = [
            // Engine part definition
            RocketPartModel(imageNameBase: "engine", partName: "Engine", information: "Engines provide thrust for the spacecraft.", size: CGSize(width: 120, height: 80), selectedColor: "metallic", colorOptions: ["metallic", "black", "white"]),
            // Body Tube part definition
            RocketPartModel(imageNameBase: "bodytube", partName: "Body Tube", information: "Body tube stores cargo within the rocket.", size: CGSize(width: 90, height: 100), selectedColor: "gray", colorOptions: ["gray", "black", "red", "blue"]),
            // Left Fin part definition
            RocketPartModel(imageNameBase: "leftfin", partName: "Left Fin", information: "Fins provide stability and control during flight.", size: CGSize(width: 60, height: 60), selectedColor: "white", colorOptions: ["white", "black", "red", "blue"]),
            // Right Fin part definition
            RocketPartModel(imageNameBase: "rightfin", partName: "Right Fin", information: "Fins provide stability and control during flight.", size: CGSize(width: 60, height: 60), selectedColor: "white", colorOptions: ["white", "black", "red", "blue"]),
            // Nose Cone part definition
            RocketPartModel(imageNameBase: "nosecone", partName: "Nose Cone", information: "Nose cone reduces aerodynamic drag during ascent.", size: CGSize(width: 90, height: 80), selectedColor: "black", colorOptions: ["white", "black", "metallic"]),
            // Fuel Tank part definition
            RocketPartModel(imageNameBase: "fueltank", partName: "Fuel Tank", information: "Fuel tank stores propellant for the engines.", size: CGSize(width: 60, height: 60), selectedColor: "metallic", colorOptions: ["metallic"])
        ]
        // Initialize an empty dictionary to track parts placement.
        let initialDroppedItems: [UUID: CGPoint] = [:]
        // Initialize the ViewModel with the predefined parts and placement.
        _viewModel = StateObject(wrappedValue: RocketViewModel(rocketParts: initialRocketParts, droppedItems: initialDroppedItems))
    }
    
    var body: some View {
        ZStack {
            // Set the background color of the view.
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            // Main content stack.
            VStack(spacing: 20) {
                // Title of the view.
                Text("Rocket Design")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                // Layout for rocket parts selection and CAD view.
                HStack(spacing: 20) {
                    // Column for rocket parts selection.
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Rocket Parts")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        // Scrollable view to display available rocket parts.
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 10) {
                                ForEach($viewModel.rocketParts, id: \.id) { $part in
                                    RocketPartView(part: $part)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.5))
                    .cornerRadius(20)
                    .padding(.bottom, 5)
                    
                    // CAD view for assembling the rocket.
                    CADView(viewModel: viewModel)
                        .padding()
                        .cornerRadius(20)
                        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                    // Tutorial overlay that appears over the CAD view.
                        .overlay(
                            Group {
                                if showingTutorial {
                                    TutorialView(onDismiss: {
                                        withAnimation {
                                            showingTutorial = false
                                        }
                                    })
                                    .transition(.opacity.animation(.easeInOut(duration: 0.5)))
                                } else {
                                    EmptyView()
                                }
                            }
                        )
                    
                    // List view for managing and viewing selected parts.
                    RocketPartsListView(viewModel: viewModel)
                        .padding(.horizontal)
                }
                
                // Button to navigate to the rocket display view, initiating the launch simulation.
                Button("Launch 🚀 ") {
                    isNavigateToRocketDisplayView = true
                }
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 200, height: 60)
                .background(Color.blue)
                .cornerRadius(30)
                .padding(.bottom, 30)
                .fullScreenCover(isPresented: $isNavigateToRocketDisplayView) {
                    RocketDisplayView(viewModel: viewModel)
                        .edgesIgnoringSafeArea(.all)                    
                }                    
            }
            .padding()
        }
    }
}

// Preview provider for RocketDesignView, helps with layout and design within Xcode.
struct RocketDesignView_Previews: PreviewProvider {
    static var previews: some View {
        RocketDesignView()
    }
}
