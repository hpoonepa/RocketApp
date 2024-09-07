import SwiftUI

// ObservableObject allows instances of this class to be used within SwiftUI views, enabling automatic updates when changes occur.
class RocketViewModel: ObservableObject {
    // @Published properties will trigger UI updates when their values change.
    
    // Stores an array of RocketPartModel, which represents each part of the rocket available for assembly.
    @Published var rocketParts: [RocketPartModel]
    
    // Tracks the positions of dropped items on the canvas. Keys are UUIDs of rocket parts, and values are their positions.
    @Published var droppedItems: [UUID: CGPoint]
    
    // Tracks the vertical position of the rocket, used for animations or positioning in the view.
    @Published var rocketPositionY: CGFloat = 0 
    
    // Initializes the model with predefined rocket parts and their positions if they've been placed.
    init(rocketParts: [RocketPartModel], droppedItems: [UUID: CGPoint]) {
        self.rocketParts = rocketParts
        self.droppedItems = droppedItems
    }
    
    // Computes the lowest point among all placed rocket parts, which could be used for positioning or animations.
    var lowestRocketPartPosition: CGPoint? {
        guard let firstPosition = droppedItems.first?.value else {
            return nil // Returns nil if no parts have been placed.
        }
        
        // Iterates through all dropped items to find the lowest Y position.
        var lowestYPosition = firstPosition.y
        droppedItems.values.forEach { position in
            if position.y > lowestYPosition {
                lowestYPosition = position.y
            }
        }
        
        // Returns the point with the lowest Y position.
        return CGPoint(x: firstPosition.x, y: lowestYPosition)
    }
    
    // Checks if all rocket parts have been used in the assembly.
    func allPartsUsed() -> Bool {
        // Returns true only if each part's ID is found within the keys of droppedItems.
        return rocketParts.allSatisfy { part in droppedItems.keys.contains(part.id) }
    }
    
    // Generates a descriptive string of any missing parts that haven't been placed on the canvas.
    func missingPartsDescription() -> String {
        // Filters for parts that are not found in the droppedItems dictionary.
        let missingParts = rocketParts.filter { !droppedItems.keys.contains($0.id) }
        
        // Maps the missing parts to their names and joins them into a single string.
        let missingPartsNames = missingParts.map { $0.partName }.joined(separator: ", ")
        return "You are missing: \(missingPartsNames)."
    }
    
    // Resets the game by clearing the positions of dropped items, allowing for a new assembly.
    func resetGame() {
        droppedItems.removeAll()
    }
}
