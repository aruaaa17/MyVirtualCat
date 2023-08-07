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
    
    @State private var isPlacementEnable = false
    
    @StateObject private var vm = IconViewModel()
    
//    func test() -> some View {
//        print(isPlacementEnable)
//        return Text("test")
//    }
    
    var models:[String] = ["fish", "ball", "heart"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(vm: vm).edgesIgnoringSafeArea(.all)
            
            if self.isPlacementEnable {
                PlacementButtonView(isPlacementEnable: self.$isPlacementEnable)
//                test()
            } else {
                ModelPickerView(models: self.models, vm: vm, isPlacementEnable: self.$isPlacementEnable)}
            
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
        
//        let scene = try! Experience.loadFish()
//        _ = scene.actions.feed.onAction
        
        arView.addCoachingOverlay()
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(vm: vm)
    }
}

struct ModelPickerView: View {
    
    var models: [String]
    let vm: IconViewModel
    @Binding var isPlacementEnable: Bool
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 25) {
//                Spacer()
                ForEach(0 ..< self.models.count, id: \.self) { index in
                    Button(action: {
                        print("DEBUG: click model button\(self.models[index])")
                        self.isPlacementEnable = true
                        
                    }, label: {
                        Image(uiImage: UIImage(named: self.models[index])!)
                            .resizable()
                            .cornerRadius(15)
                            .frame(width: 80, height: 80)
//                            .aspectRatio(1/1, contentMode: .fit)
                            .border(.black, width: vm.selectedIcon == self.models[index] ? 1.0: 0.0)
                            .background(Color.white)
                            .onTapGesture { vm.selectedIcon = self.models[index] }
                    })
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
        }
        .padding(20)
        .background(Color.black.opacity(0.5))
    }
}

struct PlacementButtonView: View {
    @Binding var isPlacementEnable: Bool
    var body: some View {
        HStack{
            // cancel button
            Button(action:{
                print("DEBUG: click cancel")
                self.resetPlacementParameters()
            }){
                Image(systemName: "xmark")
                    .frame(width: 30, height: 30)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
            //confirm button
            Button(action:{
                print("DEBUG: click confirm")
                self.resetPlacementParameters()
            }){
                Image(systemName: "checkmark")
                    .frame(width: 30, height: 30)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
        }
    }
    func resetPlacementParameters() {
        self.isPlacementEnable = false
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
