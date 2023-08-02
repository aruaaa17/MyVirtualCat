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
    @StateObject private var vm = IconViewModel()
    let icons = ["fish", "ball", "heart"]
    
    var body: some View {
        VStack {
            ARViewContainer(vm: vm).edgesIgnoringSafeArea(.all)
            ScrollView(.horizontal) {
                HStack(spacing: 25) {
                    ForEach(icons, id: \.self) { name in
                        Image(name)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .border(.black, width: vm.selectedIcon == name ? 1.0: 0.0)
                            .onTapGesture {
                                vm.selectedIcon = name
                            }
                        Spacer()
                    }
                }
            }
        }
    }
}




struct ARViewContainer: UIViewRepresentable {
    
    let vm: IconViewModel
    
    // Set up basic ARView
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        // Add ARWorld config
        let session = arView.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        session.run(config)
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        context.coordinator.arView = arView
        arView.addCoachingOverlay()
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(vm: vm)
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
