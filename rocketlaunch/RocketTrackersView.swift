import SwiftUI

// View responsible for displaying the assembled rocket parts and the rocket fire animation.
struct RocketTrackersView: View {
    // Observes changes in the RocketViewModel, which contains the logic and data for rocket assembly.
    @ObservedObject var viewModel: RocketViewModel
    // Binding to a CGFloat value that represents the vertical offset of the rocket in the parent view.
    @Binding var rocketOffset: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            // Calculate the center X coordinate based on the view's width.
            let centerX = geometry.size.width / 2
            // Adjust the center Y coordinate based on the given rocketOffset, allowing for vertical movement.
            let centerY = geometry.size.height / 2 + rocketOffset
            
            // Iterate through each rocket part in the viewModel.
            ForEach(viewModel.rocketParts) { part in
                // Check if the current part has been placed (has a position in droppedItems).
                if let position = viewModel.droppedItems[part.id] {
                    Image(part.imageName) // Display the part's image.
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: part.size.width, height: part.size.height) // Use part-specific dimensions.
                    // Position each part dynamically based on its stored position and adjustments for assembly visualization.
                        .position(x: positionForPart(part: part, centerX: centerX, position: position), y: centerY + (position.y - geometry.size.height / 2))
                    // Apply an animation for when the part's position changes.
                        .animation(.easeInOut, value: position)
                }
            }
            
            // Optionally, display rocket fire animation based on the lowest part's position.
            if let lowestRocketPartPosition = viewModel.lowestRocketPartPosition {
                Image("rocketfire") // Rocket fire image for visual effect.
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 100) // Static dimensions for the rocket fire image.
                // Position the rocket fire just below the lowest rocket part.
                    .position(x: centerX, y: centerY + (lowestRocketPartPosition.y - geometry.size.height / 2) + 60)
                // Apply an animation for when the lowest part's position changes.
                    .animation(.easeInOut, value: lowestRocketPartPosition)
            }
        }
    }
    
    // Helper function to adjust the horizontal position of specific rocket parts for visual accuracy.
    private func positionForPart(part: RocketPartModel, centerX: CGFloat, position: CGPoint) -> CGFloat {
        // Special handling for the horizontal position of left and right fins.
        if part.partName == "Left Fin" {
            return centerX - 30 // Position the left fin slightly left of center.
        } else if part.partName == "Right Fin" {
            return centerX + 30 // Position the right fin slightly right of center.
        } else if part.partName == "Body Tube" {
            return centerX + 2 // Minor adjustment for the body tube, if needed.
        } else {
            return centerX // Other parts are centered without horizontal adjustment.
        }
    }
}
