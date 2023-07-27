//
//  ContentView.swift
//  MyVirtualCat
//
//  Created by aRua Zhang on 7/25/23.
//

import ARKit
import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    // Set up basic ARView
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Load the "Cat" scene from the "Experience" Reality file
        let catAnchor = try! Experience.loadCat()
        
        // Add the cat anchor to the scene
        arView.scene.anchors.append(catAnchor)
        
        
        
        return arView
        
    }
    
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .ignoresSafeArea()
    }
}
#endif
