import SwiftUI
import UniformTypeIdentifiers

// A view designed to simulate a CAD environment for assembling rocket parts.
struct CADView: View {
    // Observes the RocketViewModel for changes, allowing the view to update dynamically.
    @ObservedObject var viewModel: RocketViewModel
    
    var body: some View {
        VStack {
            Spacer()
            // Uses GeometryReader to read the view's size and create a responsive design.
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // Creates a grid of squares representing a 2D plane for placing rocket parts.
                    ForEach(0..<60) { _ in
                        HStack(spacing: 0) {
                            ForEach(0..<70) { _ in
                                Rectangle()
                                    .fill(Color.white) // Sets the fill color of each square in the grid.
                                    .aspectRatio(1, contentMode: .fill) // Ensures each square has an equal width and height.
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height) // Sets the frame to fill the GeometryReader's size.
                .overlay(
                    // Places each rocket part on the grid based on its position in the viewModel.
                    ForEach(viewModel.rocketParts) { part in
                        if let position = viewModel.droppedItems[part.id] {
                            Image(part.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: part.size.width, height: part.size.height) // Sizes the image according to the part's dimensions.
                                .position(position) // Positions the part based on its saved location.
                            // Adds drag gesture to allow moving parts around.
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            // Updates part's position as it's dragged.
                                            let newPosition = CGPoint(x: value.location.x, y: value.location.y)
                                            viewModel.droppedItems[part.id] = newPosition
                                            
                                        }
                                        .onEnded { value in
                                            // Finalizes part's position when the drag ends.
                                            let finalPosition = CGPoint(x: value.location.x, y: value.location.y)
                                            viewModel.droppedItems[part.id] = finalPosition
                                            
                                        }
                                )
                        }
                    }
                )
            }
            .border(Color.black, width: 5) // Adds a border around the CAD area.
            .cornerRadius(45) // Rounds the corners of the CAD area.
            .padding(20) // Adds padding around the CAD area for spacing.
            Spacer()
        }
        // Implements drop functionality to add parts to the CAD area.
        .onDrop(of: [UTType.plainText.identifier], isTargeted: nil) { providers, location in
            // Handles the dropped content.
            providers.first?.loadObject(ofClass: NSString.self, completionHandler: { (object, error) in
                // Checks if the dropped content matches a rocket part's name.
                if let partName = object as? String {
                    // Finds the matching part by its name.
                    if let matchingPart = viewModel.rocketParts.first(where: { $0.imageName == partName }) {
                        DispatchQueue.main.async {
                            // Updates the part's position based on the drop location.
                            viewModel.droppedItems[matchingPart.id] = CGPoint(x: location.x, y: location.y)
                            print("Updated droppedItems: \(viewModel.droppedItems)")
                        }
                    }
                }
            })
            return true
        }
    }
}
