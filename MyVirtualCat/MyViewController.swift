//
//  MyViewController.swift
//  MyVirtualCat
//
//  Created by aRua Zhang on 8/9/23.
//

import Foundation
import UIKit
import FocusEntity
import ARKit
import SwiftUI

class MyViewController: UIViewController, UIGestureRecognizerDelegate {
    
//    var sceneView: VirtualObjectARView!

    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "🩷🩷🩷🩷🩷"
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addSubview(label)
//        view.isOpaque = false
//        view.window?.isOpaque = false
//        
//        let myView = MyView()
//        let controller = UIHostingController(rootView: myView)
//        let subview = controller.view!
//        subview.backgroundColor = .clear
//        view.backgroundColor = .clear
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }
}
