//
//  ContentView.swift
//  MyVirtualCat
//
//  Created by aRua Zhang on 7/25/23.
//

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
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
