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




struct ARViewContainer: UIViewRepresentable {
    
    // Set up basic ARView
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        // Add ARWorld config
        let session = arView.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        session.run(config)
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        // Load the "Cat" scene from the "Experience" Reality File
//        arView.scene.addAnchor(try! Experience.loadCat())
        context.coordinator.arView = arView
        arView.addCoachingOverlay()
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
