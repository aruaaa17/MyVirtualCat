//
//  ContentView.swift
//  MyVirtualCat
//
//  Created by aRua Zhang on 7/25/23.
//

import ARKit
import SwiftUI
import RealityKit
import AVFoundation

// view protocol
struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

// Add light to cat model
class Coordinator {
    
    var arView: ARView?
    var catAnchor: AnchorEntity?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        guard let arView = arView else {
            return
        }

        let location = recognizer.location(in: arView)
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let result = results.first {
            
            // Remove old cat model
            if let catAnchor = catAnchor {
                arView.scene.removeAnchor(catAnchor)
            }
            
           
            let anchor = AnchorEntity(raycastResult: result)
            
            let catEntity = try! Experience.loadCat()
                        anchor.addChild(catEntity)
            
            let lightEntity = PointLight()
            lightEntity.light.color = .orange
            lightEntity.light.intensity = 1000
            lightEntity.light.attenuationRadius = 0.5

            lightEntity.look(at: [0.05, 0.05, 0.05], from: [0.1, 0.1, 0.1], relativeTo: anchor)
            
            anchor.addChild(lightEntity)
            arView.scene.addAnchor(anchor)
            
            // Save new cat model
            catAnchor = anchor
           
        }
    }
    
}

struct ARViewContainer: UIViewRepresentable {
    
    // Set up basic ARView
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        // Load the "Cat" scene from the "Experience" Reality File
//        arView.scene.addAnchor(try! Experience.loadCat())
        context.coordinator.arView = arView

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .ignoresSafeArea()
    }
}
#endif
