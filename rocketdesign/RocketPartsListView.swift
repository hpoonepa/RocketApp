import SwiftUI

// A view that lists all rocket parts involved in the design process, showing their status.
struct RocketPartsListView: View {
    // The viewModel contains the data and logic for managing rocket parts and their placement.
    @ObservedObject var viewModel: RocketViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            // Header text indicating the section's purpose.
            Text("Rocket Parts Used")
                .font(.title) // Large, bold font for section title.
                .fontWeight(.bold)
                .foregroundColor(.white) // Text color set to white for contrast against the background.
            
            // Iterates through each rocket part in the viewModel's list.
            ForEach(viewModel.rocketParts) { part in
                HStack {
                    // Displays the name of the rocket part.
                    Text(part.partName)
                        .foregroundColor(.white) // Ensures text is visible against the background.
                    
                    // Conditionally displays a checkmark or xmark icon based on whether the part has been placed.
                    if viewModel.droppedItems.keys.contains(part.id) {
                        Image(systemName: "checkmark") // Shows a checkmark if the part has been used.
                            .foregroundColor(.green) // Green color signifies the part is placed.
                    } else {
                        Image(systemName: "xmark") // Shows an xmark if the part hasn't been placed.
                            .foregroundColor(.red) // Red color signifies the part is missing.
                    }
                }
                .padding(.trailing, -10) // Adjusts padding to align elements within the list.
            }
        }
        .padding() // Adds padding around the entire VStack for spacing.
        .background(Color.blue.opacity(0.5)) // Sets a semi-transparent blue background.
        .cornerRadius(20) // Rounds the corners of the background for a polished look.
    }
}
